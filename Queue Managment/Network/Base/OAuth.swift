//
//  OAuth.swift
//  Queue Managment
//
//  Created by WINTAA on 01.07.22.
//

import Foundation
import Alamofire

struct OAuthCredential: AuthenticationCredential {
    var token: Token?
    var requiresRefresh: Bool {
        Date(timeIntervalSinceNow: 100) > token?.expiringDate ??
        Date(timeIntervalSinceNow: 301)
    }
    
}


class OAuthAuthenticator: Authenticator {
    func apply(_ credential: OAuthCredential, to urlRequest: inout URLRequest) {
        //urlRequest.timeoutInterval = 5
        if let token = credential.token {
            urlRequest.headers.add(.authorization(bearerToken: token.accessToken))
        }
    }

    func refresh(_ credential: OAuthCredential,
                 for session: Session,
                 completion: @escaping (Result<OAuthCredential, Error>) -> Void) {
    
        AccountManager.shared.refreshToken { result in
            switch result {
            case .success(let token):
                let newCredentials = OAuthCredential(token: token)
                completion(.success(newCredentials))
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


//        let url = "\(BaseURL.identity)/client/auth/refresh-token"
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//        ]
//
//        let parameters = [
//            "refreshToken": AccountManager.shared.token!.refreshToken
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
//                    guard let data = response.data else {
//                        completion(.failure(ServerError(status: "Unknown", message: "No Data")))
//                        return
//                    }
//
//                    if response.response?.statusCode == ResponseStatusCode.badRequest.rawValue {
//                        let serverError = try? JSONDecoder().decode(ServerError.self, from: data)
//                        completion(.failure(serverError!))
//
//                        return
//                    }
//
//                    do {
//                        let result = try JSONDecoder().decode(Token.self, from: data)
//                        AccountManager.shared.token = result
//                        let newCredentials = OAuthCredential(token: result)
//                        completion(.success(newCredentials))
//                    } catch {
//                            completion(.failure(ServerError(status: "meore gaguebari", message: "No Data")))
//                    }
//                }
