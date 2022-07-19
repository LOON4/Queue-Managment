//
//  OAuth.swift
//  Queue Managment
//
//  Created by WINTAA on 01.07.22.
//

import Foundation
import Alamofire
import Resolver

struct OAuthCredential: AuthenticationCredential {
    var token: Token?
    var requiresRefresh: Bool {
        Date(timeIntervalSinceNow: 300) > token?.expiringDate ??
        Date(timeIntervalSinceNow: 301)
    }
    
}


class OAuthAuthenticator: Authenticator {
    
    @LazyInjected private var refreshTokenUseCase: RefreshTokenUseCase
    
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        //urlRequest.timeoutInterval = 5
        if let token = credential.token {
            urlRequest.headers.add(.authorization(bearerToken: token.accessToken))
        }
    }

    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
    
        refreshTokenUseCase.determineUserStatus { result in
            switch result {
            case .success(let response):
                if let token = response.token {
                    let newCredentials = OAuthCredential(token: token)
                    completion(.success(newCredentials))
                } 
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        return response.statusCode == 401
    }

    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthCredential) -> Bool {
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.token?.accessToken ?? "").value
        return urlRequest.headers["Authorization"] ?? "Bearer " == bearerToken
    }
}
