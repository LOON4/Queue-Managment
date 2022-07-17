//
//  OnboardingRouter.swift
//  Queue Managment
//
//  Created by WINTAA on 06.07.22.
//

import Foundation
import UIKit

enum FirstScreenState {
    case loginVC
    case profileVC
}

protocol OnboardingRouter {
    
    func showFirstScreen(firstScreen: FirstScreenState)
    func showLoginScreen()
    func showPasswordScreen()
    func showCheckEmailScreen()
    func showCodeEnterSceen()
    func showNewPasswordScreen()
    func showPasswordResetSuccess()
    func showLoggedInSuccessfully()
}

class OnboardingRouterImpl: OnboardingRouter {

    private static let authenticationStoryboard = {
        UIStoryboard(name: StoryboardIDK.authentication,
                    bundle: .main)
    }()
    
    private static let loginNVC = { authenticationStoryboard.instantiateViewController(withIdentifier: NavContollerIDK.loginNavigationController) as! UINavigationController
    }()
    
    private var rootViewController: UIViewController
    
    init(_ rootViewController: UIViewController){
        self.rootViewController = rootViewController
    }
            
    func showFirstScreen(firstScreen: FirstScreenState) {
        switch firstScreen {
        case .loginVC :
            self.showLoginScreen()
        case .profileVC:
            self.showLoginScreen()
            self.showLoggedInSuccessfully()
        }
        OnboardingRouterImpl.loginNVC.modalPresentationStyle = .overFullScreen
        self.rootViewController.present(OnboardingRouterImpl.loginNVC, animated: true)
    }
    
    func showLoginScreen() {
        let loginVC = OnboardingRouterImpl.authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.loginScreen)
            OnboardingRouterImpl.loginNVC.setViewControllers([loginVC], animated: true)
    }
    
    
    func showPasswordScreen() {
        let resetPasswordVC =
            OnboardingRouterImpl.authenticationStoryboard
            .instantiateViewController(withIdentifier: ControllerIDK.passwordScreen)
            OnboardingRouterImpl.loginNVC.pushViewController(resetPasswordVC, animated: true)
    }
    
    func showCheckEmailScreen(){
        let checkEmailVC =
            OnboardingRouterImpl.authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.checkEmail)
            OnboardingRouterImpl.loginNVC.pushViewController(checkEmailVC, animated: true)
    }
    
    func showCodeEnterSceen(){
        let codeEnterVC =
        OnboardingRouterImpl.authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.passwordScreenCode)
        OnboardingRouterImpl.loginNVC.pushViewController(codeEnterVC, animated: true)
    }
    
    func showNewPasswordScreen(){
        let newPasswordVC = OnboardingRouterImpl.authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.newPassword)
            OnboardingRouterImpl.loginNVC.pushViewController(newPasswordVC, animated: true)
    }
    
    func showPasswordResetSuccess(){
        let passwordResetSuccessVC = OnboardingRouterImpl.authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.passwordResetSuccess)
            OnboardingRouterImpl.loginNVC.pushViewController(passwordResetSuccessVC, animated: true)
    }
    
    func showLoggedInSuccessfully(){
        let loggedInSuccessfullyVC = OnboardingRouterImpl.authenticationStoryboard.instantiateViewController(withIdentifier: "LoggedInSuccessfully")
            OnboardingRouterImpl.loginNVC.pushViewController(loggedInSuccessfullyVC, animated: true)
    }
}


