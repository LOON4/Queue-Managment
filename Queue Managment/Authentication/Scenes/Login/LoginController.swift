//
//  LoginController.swift
//  Queue Managment
//
//  Created by WINTAA on 22.06.22.
//

import Foundation
import UIKit




class LoginController: UIViewController {
    
    @IBOutlet weak var appNameLabel: UILabel!
    
    @IBOutlet weak var emailTextField: PaddingTextField!
    @IBOutlet weak var passwordTextField: PaddingTextField!
    
    @IBOutlet weak var keepMeSignIcon: CheckboxButton!
    
    @IBOutlet weak var signInButton: QueueButtonOne!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    let accountManager = AccountManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        adjustLabelFontSizes()
    }

    
    @IBAction func rememberMeClicked() {
        keepMeSignIcon.toggle()
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        LoginWireFrame.showPasswordScreen(for: self)
    }
    
    @IBAction func signInButtonClicked() {
        accountManager.login(email: "ceo@mail.com", passcode: "Aa12345.", rememberMe: true){
            result in
            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error)
            }
        }
        LoginWireFrame.showPasswordScreen(for: self)
    }
    
    private func adjustLabelFontSizes () {
        appNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupTextFields () {
        emailTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        passwordTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        emailTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
        passwordTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
    }
}

extension LoginController: UITextFieldDelegate {
    
}
