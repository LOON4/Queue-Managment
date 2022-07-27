//
//  SplashScreenUsaCase.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation
import Resolver

protocol RestoreTokenUsecase {
    func determineUserStatus(completion:  @escaping (Result<(userStatus: UserStatus,
                                                             token: Token?), ServerError>) -> Void)
}

enum UserStatus {
    case sessionRestored
    case sessionDoesntExist
    case sessionExpired
}

class RestoreTokenUsecaseImpl: RestoreTokenUsecase {
    
    @LazyInjected private var userDefaults: UserDefaultsRepository
    @LazyInjected private var userSession: UserSessionRepository
    
    func determineUserStatus(completion:  @escaping (Result<(userStatus: UserStatus,
                                                             token: Token?),
                                                             ServerError>) -> Void) {
        
        if userDefaults.isRemembered() {
            userSession.readToken()
            userSession.refreshToken { result in
                
                switch result {
                case .success(let APIToken):
                    let token = Token(APIToken)
                    Token.shared = token
                    if self.userDefaults.isRemembered() {
                        self.userSession.saveToken(token: token)
                    }
                    completion(.success((.sessionRestored, token)))
                case .failure(let error):
                    Token.shared = nil
                    self.userSession.deleteToken()
                    self.userDefaults.setIsRemembered(remember: false)
                    if error.status == .badRequest {
                        completion(.success((.sessionExpired, nil)))
                    }
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success((.sessionDoesntExist, nil)))
        }
    }
}
