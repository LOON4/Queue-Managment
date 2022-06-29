//
//  LoginWireFrame.swift
//  Queue Managment
//
//  Created by WINTAA on 22.06.22.
//

import Foundation
import UIKit

protocol LoginWireFrameProtocol {
    static func showLoginScreen(for view: UIViewController)
    static func showPasswordScreen(for view: UIViewController)
    static func showCheckEmailScreen(for view: UIViewController)
    static func showCodeEnterSceen(for view: UIViewController)
    static func showNewPasswordScreen(for view: UIViewController)
    static func showPasswordResetSuccess(for view: UIViewController)

}

class LoginWireFrame: LoginWireFrameProtocol {

    static let authenticationStoryboard = {
        UIStoryboard(name: StoryboardIDK.authentication, bundle: .main)
    }()
    
    static let loginNVC = {
        authenticationStoryboard
            .instantiateViewController(withIdentifier: NavContollerIDK.loginNavigationController)
            as! UINavigationController
    }()
    
    class func showLoginScreen(for view: UIViewController) {
        let loginVC = authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.loginScreen)
        loginNVC.setViewControllers([loginVC], animated: true)
        loginNVC.modalPresentationStyle = .overFullScreen
        view.present(loginNVC, animated: true)
    }
    
    
    class func showPasswordScreen(for view: UIViewController) {
        let resetPasswordVC = authenticationStoryboard
            .instantiateViewController(withIdentifier: ControllerIDK.passwordScreen)
        loginNVC.pushViewController(resetPasswordVC, animated: true)
    }
    
    class func showCheckEmailScreen(for view: UIViewController){
        let checkEmailVC = authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.checkEmail)
        loginNVC.pushViewController(checkEmailVC, animated: true)
    }
    
    class func showCodeEnterSceen(for view: UIViewController){
        let codeEnterVC = authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.passwordScreenCode)
        loginNVC.pushViewController(codeEnterVC, animated: true)
    }
    
    class func showNewPasswordScreen(for view: UIViewController){
        let newPasswordVC = authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.newPassword)
        loginNVC.pushViewController(newPasswordVC, animated: true)
    }
    
    class func showPasswordResetSuccess(for view: UIViewController){
        let passwordResetSuccessVC = authenticationStoryboard.instantiateViewController(withIdentifier: ControllerIDK.passwordResetSuccess)
        loginNVC.pushViewController(passwordResetSuccessVC, animated: true)
    }
    
    
    
}
