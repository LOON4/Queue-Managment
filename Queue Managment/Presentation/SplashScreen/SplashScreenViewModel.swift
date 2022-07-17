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
    @LazyInjected private var splashScreenUsaCase: SplashScreenUseCase
    @LazyInjected var router: OnboardingRouter
    @LazyInjected private var userDefaults: UserDefaultsRepository
    
    @Published var userStatus: UserStatusAfterLaunch? = nil
    @Published var isLoading = false
    
    
    func determineUserStatus(){
        if userDefaults.isRemembered() {
            isLoading = true
        }
        self.splashScreenUsaCase.determineUserStatus(){ [self] result in
            switch result {
            case .success(let userStatus):
                self.userStatus = userStatus
            case .failure(_):
                break
            }
        }
    }
}
