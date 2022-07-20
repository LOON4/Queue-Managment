//
//  NewPasswordController.swift
//  Queue Managment
//
//  Created by WINTAA on 27.06.22.
//

import Foundation
import UIKit
import Resolver
import Combine

class NewPasswordController: UIViewController {
    
    
    @IBOutlet weak var newPasswordTextField: PaddingTextField!
    
    @IBOutlet weak var repeatPasswordTextField: PaddingTextField!
    
    @LazyInjected var newPasswordViewModel: NewPasswordViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        newPasswordTextField.becomeFirstResponder()
        setUpTextField()
    }
    
    @IBAction func resetPasswordClicked() {
        newPasswordViewModel.router.showPasswordResetSuccess()
    }
    
    private func setUpTextField () {
        newPasswordTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        repeatPasswordTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        newPasswordTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
        repeatPasswordTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
    }
}
