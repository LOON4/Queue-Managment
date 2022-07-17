//
//  SplashScreenUsaCase.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation
import Resolver

protocol SplashScreenUsaCase {
    func determineUserStatus(completion:  @escaping (Result<UserStatusAfterLaunch, ServerError>) -> Void)
}

enum UserStatusAfterLaunch {
    case sessionRestored
    case sessionDoesntExist
    case sessionExpired
}

class SplashScreenUsaCaseImpl: SplashScreenUsaCase{
    
    @LazyInjected private var userDefaults: UserDefaultsRepository
    @LazyInjected private var userSession: UserSessionRepository
    
    func determineUserStatus(completion:  @escaping (Result<UserStatusAfterLaunch, ServerError>) -> Void) {
        
        if userDefaults.isRemembered() {
            userSession.readToken()
            userSession.refreshToken { result in
                switch result {
                case .success:
                    completion(.success(.sessionRestored))
                case .failure(let serverError):
                    if serverError.status == .badRequest {
                        completion(.success(.sessionExpired))
                    }
                    completion(.failure(serverError))
                }
            }
        } else {
            completion(.success(.sessionDoesntExist))
        }
    }
}
