//
//  ForgetPasswordProccedureViewModel.swift
//  Queue Managment
//
//  Created by WINTAA on 21.07.22.
//

import Foundation
import Combine
import Resolver

class ForgetPasswordProccedureViewModel {
    @LazyInjected var router: OnboardingRouter
    @LazyInjected var forgotPasswordUsecase: ForgetPasswordProccedureUsecase
    
    var forgetPasswordCredentials: ForgetPasswordCredentials
    var currentStage: ForgetPasswordProccedureStage
    private let validationResultPassthourgh =
        PassthroughSubject< Result<Void, AuthenticationError>, Never >()
    
    var validationResult: AnyPublisher< Result<Void, AuthenticationError>, Never > {
        validationResultPassthourgh.eraseToAnyPublisher()
    }
    
    init(_ credentials: ForgetPasswordCredentials = ForgetPasswordCredentials(),
         _ stage: ForgetPasswordProccedureStage = .checkEmail){
        
        self.forgetPasswordCredentials = credentials
        self.currentStage = stage
    }
    
    func validateForgotPasswordProccedure(){
        if currentStage == .checkPassword && !forgetPasswordCredentials.passwordsMatch {
            self.validationResultPassthourgh.send(
                .failure(AuthenticationError("Passwords don't match")))
        } else {
            forgotPasswordUsecase.forgetPasswordProccedure(credentials: forgetPasswordCredentials,
                                          for: currentStage) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(_):
                    self.validationResultPassthourgh.send(.success(()))
                case .failure(let error):
                    self.validationResultPassthourgh.send(
                        .failure(AuthenticationError(error.message)))
                }
            }
        }
    }
    
    func navigateToNextScene(){
        switch currentStage {
        case .checkEmail:
            navigateToCheckEmailScene()
        case .tryagain:
            navigateToCheckCode()
        case .checkCode:
            navigateToEnterNewPassword()
        case .checkPassword:
            navigateToPasswordResecSucces()
        }
    }
    
    private func navigateToCheckEmailScene() {
        router.showCheckEmailScreen(forgetPasswordCredentials)
    }
    
    private func navigateToCheckCode () {
        router.showCodeEnterSceen(forgetPasswordCredentials)
    }
    
    private func navigateToEnterNewPassword() {
        router.showNewPasswordScreen(forgetPasswordCredentials)
    }
    
    func navigateToPasswordResecSucces() {
        router.showPasswordResetSuccess()
    }
}
