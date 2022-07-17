//
//  QueueUserSessionRepository.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation
import Resolver

class QueueUserSessionRepository: UserSessionRepository {
    
    @LazyInjected private var dataStore: UserSessionDataStore
    @LazyInjected private var remoteAPI: AuthRemoteAPI
    @LazyInjected private var userDefaults: UserDefaultsRepository
    
    func readToken(){
        Token.shared = dataStore.getToken()

    }
    
    func loginUser(email: String, passcode: String, rememberMe: Bool,
                completion: @escaping (Result<Token, ServerError>) -> Void) {
        remoteAPI.signIn(email: email,
                         passcode: passcode,
                         rememberMe: rememberMe){ [self] result in
            switch result {
            case .success(let APIToken):
                let token = Token(APIToken)
                Token.shared = token
                dataStore.setToken(token: token)
                userDefaults.setIsRemembered(remember: rememberMe)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func refreshToken(completion: @escaping (Result<Token, ServerError>) -> Void) {
        remoteAPI.refreshToken(){ [self] result in
            switch result {
            case .success(let APIToken):
                let token = Token(APIToken)
                Token.shared = token
                dataStore.setToken(token: token)
                completion(.success(token))
            case .failure(let error):
                Token.shared = nil
                dataStore.unsetToken()
                userDefaults.setIsRemembered(remember: false)
                completion(.failure(error))
            }
        }
    }

}
