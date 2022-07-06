//
//  OnboardingRouter.swift
//  Queue Managment
//
//  Created by WINTAA on 06.07.22.
//

import Foundation
import UIKit

protocol OnboardingRouter {
    func showPasswordReset()
    func showProfileScene()
}

class OnboardingRouterImpl: OnboardingRouter {
    
    
    private let nc: UINavigationController
    private let authStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
    init(nc: UINavigationController) {
        self.nc = nc
    }
    
    func showPasswordReset() {
        let vc = authStoryboard.instantiateViewController(withIdentifier: "ResetPasswordController")
        nc.pushViewController(vc, animated: true)
    }
    
    func showProfileScene() {
        let vc = BaseViewController<ProfileScreen>()
        nc.pushViewController(vc, animated: true)
    }
}


class ProfileScreen: UIView, ScreenNavigationEventListener {
    let vm = ProfileViewModel()
    
    
    
}

class ProfileViewModel {
    func fetchData() {
        print("success")
    }
}
