//
//  AuthRemoteAPI.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation

protocol AuthRemoteAPI {
  
  func signIn(email: String, passcode: String, rememberMe: Bool,
              completion: @escaping (Result<APIToken, ServerError>) -> Void)
  func refreshToken(completion:  @escaping (Result<APIToken, ServerError>) -> Void)
    
}

class AuthRemoteAPIImpl: AuthRemoteAPI {
        
    func signIn(email: String, passcode: String, rememberMe: Bool,
                completion: @escaping (Result<APIToken, ServerError>) -> Void){
            let loginService = LoginService(email: email, password: passcode, rememberMe: rememberMe)
            loginService.execute { result in
                switch result {
                case .success(let token):
                    completion(.success(token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func refreshToken(completion:  @escaping (Result<APIToken, ServerError>) -> Void) {
        guard let refreshToken = Token.shared?.refreshToken else {
            completion(.failure(ServerError(status: .localRefreshTokenDoesntExist,
                                            message: "RefreshToken not found")))
            return
        }
        
        let refreshTokenService = RefreshTokenService(refreshToken: refreshToken)
        refreshTokenService.execute { result in
            switch result {
            case .success(let token):
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
