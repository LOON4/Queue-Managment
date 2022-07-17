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
    
    func loginUser(email: String, passcode: String, rememberMe: Bool,
                   completion: @escaping (Result<Token, ServerError>) -> Void) {
        userSession.loginUser(email: email,
                              passcode: passcode,
                              rememberMe: rememberMe){ result in
            completion(result)
        }
    }
    
    
}
