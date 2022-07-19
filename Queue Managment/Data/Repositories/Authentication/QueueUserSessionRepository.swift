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
    
    func saveToken(token: Token){
        dataStore.setToken(token: token)
    }
    
    func deleteToken(){
        dataStore.unsetToken()
    }
    
    func loginUser(email: String, passcode: String, rememberMe: Bool,
                completion: @escaping (Result<APIToken, ServerError>) -> Void) {
        remoteAPI.signIn(email: email,
                         passcode: passcode,
                         rememberMe: rememberMe){ result in
            completion(result)
        }
    }

    func refreshToken(completion: @escaping (Result<APIToken, ServerError>) -> Void) {
        remoteAPI.refreshToken(){ result in
            completion(result)
        }
    }
    
    func forgetPasswordProccedure(credentials: ForgetPasswordCredentials, for stage: Any,
                                  completion: @escaping (Result<Bool, ServerError>) -> Void) {
        
    }
    
}
