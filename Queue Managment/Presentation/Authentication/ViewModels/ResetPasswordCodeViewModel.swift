//
//  ResetPasswordCodeViewModel.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 17.07.22.
//

import Foundation
import Resolver
import Combine

class ResetpasswordCodeViewmodel {
    
    @LazyInjected var router: OnboardingRouter
    @LazyInjected var forgotPasswordUsecase: ForgetPasswordProccedureUsecase
    
    var forgetPasswordCredentials: ForgetPasswordCredentials
    
    private let validationResultPassthourgh =
        PassthroughSubject< Result<Void, ServerError>, Never >()
    
    var validationResult: AnyPublisher< Result<Void, ServerError>, Never > {
        validationResultPassthourgh.eraseToAnyPublisher()
    }
    
    init(_ forgetPasswordCredentials: ForgetPasswordCredentials){
        self.forgetPasswordCredentials = forgetPasswordCredentials
    }
    
    func checkCode() {
        
        forgotPasswordUsecase.forgetPasswordProccedure(credentials: forgetPasswordCredentials,
                                                       for: .checkCode) { [weak self] result in
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
    
    func navigateToEnterNewPassword() {
        router.showNewPasswordScreen(forgetPasswordCredentials)
    }
    
   
}
