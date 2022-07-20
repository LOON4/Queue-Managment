//
//  ForgetPasswordProccedureUsacase.swift
//  Queue Managment
//
//  Created by WINTAA on 20.07.22.
//

import Foundation
import Resolver

protocol ForgetPasswordProccedureUsecase {
    func forgetPasswordProccedure(credentials: ForgetPasswordCredentials,
                                  for stage: ForgetPasswordProccedureStage,
                                  completion: @escaping (Result<NoReply, ServerError>) -> Void)
}

class ForgetPasswordProccedureUsecaseImpl: ForgetPasswordProccedureUsecase {
    
    @LazyInjected var userSession: QueueUserSessionRepository


    func forgetPasswordProccedure(credentials: ForgetPasswordCredentials,
                                  for stage: ForgetPasswordProccedureStage,
                                  completion: @escaping (Result<NoReply, ServerError>) -> Void) {
        userSession.forgetPasswordProccedure(credentials: credentials,
                                             for: stage) { result in
            completion(result)
        }
    }
    
}
