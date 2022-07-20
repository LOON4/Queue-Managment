//
//  UserSessionRepository.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation

protocol UserSessionRepository {
    func readToken()
    func saveToken(token: Token)
    func deleteToken()
    func loginUser(email: String, passcode: String, rememberMe: Bool,
                completion: @escaping (Result<APIToken, ServerError>) -> Void)
    func refreshToken(completion:  @escaping (Result<APIToken, ServerError>) -> Void)
    func forgetPasswordProccedure(credentials: ForgetPasswordCredentials,
                                  for stage: ForgetPasswordProccedureStage,
                                  completion: @escaping (Result<NoReply, ServerError>) -> Void)
}

