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
    @LazyInjected private var loginUsercase: LoginUsecase
    @LazyInjected var router: OnboardingRouter

    @Published var isLoading = false
    private let validationResultPassthourgh = PassthroughSubject<Void, Error>()

    var validationResult: AnyPublisher<Void, Error> {
        validationResultPassthourgh.eraseToAnyPublisher()
    }

    var email = ""
    var passcode = ""
    var rememberMe = true
    
    func loginUser(){
        isLoading = true
        loginUsercase.loginUser(email: email,
                                passcode: passcode,
                                rememberMe: rememberMe){ [self] result in
            isLoading = false
            switch result {
            case .success(let token):
                print(token)
                router.showLoggedInSuccessfully()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
