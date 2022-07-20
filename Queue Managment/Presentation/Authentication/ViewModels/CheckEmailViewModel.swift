//
//  CheckEmailViewModel.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 17.07.22.
//

import Foundation
import Resolver
import Combine

class CheckEmailViewModel {
    @LazyInjected var router: OnboardingRouter
    @LazyInjected var forgotPasswordUsecase: ForgetPasswordProccedureUsecase
    
    var forgetPasswordCredentials: ForgetPasswordCredentials
    
    init(_ forgetPasswordCredentials: ForgetPasswordCredentials){
        self.forgetPasswordCredentials = forgetPasswordCredentials
    }
    
    func resendCode(){
        
        forgotPasswordUsecase.forgetPasswordProccedure(credentials: forgetPasswordCredentials,
                                                       for: .checkEmail){_ in}
    }
    
    func navigateToCheckCode () {
        router.showCodeEnterSceen(forgetPasswordCredentials)
    }
}
