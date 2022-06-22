//
//  LoginWireFrame.swift
//  Queue Managment
//
//  Created by WINTAA on 22.06.22.
//

import Foundation
import UIKit

protocol LoginWireFrameProtocol {
    static func presentLoginScreen(for view: UIViewController)
}

class LoginWireFrame: LoginWireFrameProtocol {

    static let authenticationStoryboard = {
        UIStoryboard(name: "Authentication", bundle: .main)
    }()
    
    class func presentLoginScreen(for view: UIViewController) {
        let loginVC = authenticationStoryboard
            .instantiateViewController(withIdentifier: "LoginController")
        loginVC.modalPresentationStyle = .overFullScreen
        view.present(loginVC, animated: true)
    }
    
    
}
