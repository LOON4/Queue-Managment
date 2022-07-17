//
//  UserSessionRepository.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation

protocol UserSessionRepository {
    func readToken()
    func loginUser(email: String, passcode: String, rememberMe: Bool,
                completion: @escaping (Result<Token, ServerError>) -> Void)
    func refreshToken(completion:  @escaping (Result<Token, ServerError>) -> Void)
}

