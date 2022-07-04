//
//  AccountManager.swift
//  Queue Managment
//
//  Created by WINTAA on 01.07.22.
//

import Foundation
import Alamofire

class AccountManager {
    static let shared = AccountManager()
    private init() {}
    
    let userDefaultsManager = UserDefaultsManager.shared
    var token: Token? {
        didSet {
            RequestData.sharedInterceptor.credential?.token = token
        }
    }
    
    func login(email: String, passcode: String, rememberMe: Bool,
            completion: @escaping (Result<Token, ServerError>) -> Void){
        let loginService = LoginService(email: email, password: passcode, rememberMe: rememberMe)
        loginService.execute { [self] result in
            switch result {
            case .success(let token):
                self.token = token
                userDefaultsManager.setToken(token: token)
                if rememberMe {
                    userDefaultsManager.setIsRemembered(remember: rememberMe)
                    userDefaultsManager.setEmail(email: email)
                }
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func refreshToken(completion:  @escaping (Result<Token, ServerError>) -> Void) {
        guard let token = token else {
            SplashScreenController.showFirstScreenSemaphore.signal()
            completion(.failure(ServerError(status: "302", message: "no token to refresh")))
            return
        }
        let refreshTokenService = RefreshTokenService(refreshToken: token.refreshToken)
        refreshTokenService.execute { [self] result in
            switch result {
            case .success(let token):
                self.token = token
                userDefaultsManager.setToken(token: token)
                completion(.success(token))
            case .failure(let error):
                self.token = nil
                userDefaultsManager.unsetToken()
                userDefaultsManager.setIsRemembered(remember: false)
                completion(.failure(error))
            }
        }
    }
    
    
    func configure(completion:  @escaping (Bool) -> Void){
        token = userDefaultsManager.getToken()
        refreshToken { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}

