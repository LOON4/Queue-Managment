//
//  LoginViewModel.swift
//  Queue Managment
//
//  Created by WINTAA on 17.07.22.
//

import Foundation
import Resolver
import Combine

class LoginViewModel {
    @LazyInjected private var loginUsecase: LoginUsecase
    @LazyInjected var router: OnboardingRouter

    @Published var isLoading = false
    private let validationResultPassthourgh =
        PassthroughSubject< Result<Void, AuthenticationError>, Never >()

    var validationResult: AnyPublisher< Result<Void, AuthenticationError>, Never > {
        validationResultPassthourgh.eraseToAnyPublisher()
    }

    var email = ""
    var passcode = ""
    var rememberMe = true
    
    func loginUser(){
        isLoading = true
        loginUsecase.loginUser(email: email,
                                passcode: passcode,
                                rememberMe: rememberMe){ [self] result in
            isLoading = false
            switch result {
            case .success(_):
                validationResultPassthourgh.send(.success(()))
            case .failure(let error):
                validationResultPassthourgh.send(.failure(AuthenticationError(error.message)))
                break
            }
        }
    }
    
}
