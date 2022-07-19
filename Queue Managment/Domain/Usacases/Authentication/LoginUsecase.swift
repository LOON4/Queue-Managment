//
//  LoginUsecase.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation
import Resolver

protocol LoginUsecase {
    func loginUser(email: String, passcode: String, rememberMe: Bool,
                   completion: @escaping (Result<Token, ServerError>) -> Void)
}

class LoginUsecaseImpl: LoginUsecase {
    
    @LazyInjected private var userSession: UserSessionRepository
    @LazyInjected private var userDefaults: UserDefaultsRepository
    
    func loginUser(email: String, passcode: String, rememberMe: Bool,
                   completion: @escaping (Result<Token, ServerError>) -> Void) {
        userSession.loginUser(email: email,
                              passcode: passcode,
                              rememberMe: rememberMe){ result in
            switch result {
            case .success(let APIToken):
                let token = Token(APIToken)
                Token.shared = token
                if rememberMe {
                    self.userSession.saveToken(token: token)
                }
                self.userDefaults.setIsRemembered(remember: rememberMe)
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }            
        }
    }
    
    
}
