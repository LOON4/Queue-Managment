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
    
    var forgetPasswordCredentials = ForgetPasswordCredentials()
    private let validationResultPassthourgh =
        PassthroughSubject< Result<Void, ServerError>, Never >()
    
    var validationResult: AnyPublisher< Result<Void, ServerError>, Never > {
        validationResultPassthourgh.eraseToAnyPublisher()
    }
    
    func checkEmail() {
        
    }
    
}
