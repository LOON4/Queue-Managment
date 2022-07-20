//
//  ResetPasswordViewModel.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 17.07.22.
//

import Foundation
import Resolver
import Combine

class ResetPasswordViewModel {
    @LazyInjected var router: OnboardingRouter
    @LazyInjected var forgotPasswordUsecase: ForgetPasswordProccedureUsecase
    
    var forgetPasswordCredentials = ForgetPasswordCredentials()
    private let validationResultPassthourgh =
        PassthroughSubject< Result<Void, ServerError>, Never >()
    
    var validationResult: AnyPublisher< Result<Void, ServerError>, Never > {
        validationResultPassthourgh.eraseToAnyPublisher()
    }
    
    func checkEmail() {
        forgotPasswordUsecase.forgetPasswordProccedure(credentials: forgetPasswordCredentials,
                                      for: .checkEmail) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(_):
                self.validationResultPassthourgh.send(.success(()))
            case .failure(let error):
                self.validationResultPassthourgh.send(.failure(error))
            }
        }
    }
    
    func navigateToCheckEmailScene() {
        router.showCheckEmailScreen(forgetPasswordCredentials)
    }
}
