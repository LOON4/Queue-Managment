//
//  NewPasswordViewModel.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 17.07.22.
//

import Foundation
import Resolver
import Combine

class NewPasswordViewModel {
    
    @LazyInjected var router: OnboardingRouter
    @LazyInjected var forgotPasswordUsecase: ForgetPasswordProccedureUsecase

    var forgetPasswordCredentials: ForgetPasswordCredentials
        
    var newPasswordTextField = ""
    var repeatPasswordTextField = ""
    
    private let validationResultPassthourgh =
        PassthroughSubject< Result<Void, ServerError>, Never >()
    
    var validationResult: AnyPublisher< Result<Void, ServerError>, Never > {
        validationResultPassthourgh.eraseToAnyPublisher()
    }
    
    init(_ forgetPasswordCredentials: ForgetPasswordCredentials){
        self.forgetPasswordCredentials = forgetPasswordCredentials
    }
    
    func checkPassword() {
        if newPasswordTextField == repeatPasswordTextField {
            forgetPasswordCredentials.newPassword = newPasswordTextField
            forgotPasswordUsecase.forgetPasswordProccedure(credentials: forgetPasswordCredentials,
                                                           for: .checkPassword) { [weak self] result in
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
        } else {
            self.validationResultPassthourgh.send(.failure(ServerError(status: .unknown,
                                                                       message: "Password doesn't match")))
        }
    }
    
    func navigateToPasswordResecSucces() {
        router.showPasswordResetSuccess()
    }
}

