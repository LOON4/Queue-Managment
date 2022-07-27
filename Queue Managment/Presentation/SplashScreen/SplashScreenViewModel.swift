//
//  SplashScreenViewModel.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation
import Resolver
import Combine

class SplashScreenViewModel {
    @LazyInjected private var splashScreenUsaCase: RestoreTokenUsecase
    @LazyInjected var router: OnboardingRouter
    @LazyInjected private var userDefaults: UserDefaultsRepository
    
    @Published var userStatus: UserStatus? = nil
    @Published var isLoading = false
    
    
    func determineUserStatus(){
        if userDefaults.isRemembered() {
            isLoading = true
        }
        self.splashScreenUsaCase.determineUserStatus(){ [self] result in
            switch result {
            case .success(let response):
                self.userStatus = response.userStatus
            case .failure(_):
                break
            }
        }
    }
}
