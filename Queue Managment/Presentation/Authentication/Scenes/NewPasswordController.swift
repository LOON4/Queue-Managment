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
import SwiftUI

class NewPasswordController: UIViewController {
    
    
    @IBOutlet weak var newPasswordTextField: PaddingTextField!
    @IBOutlet weak var repeatPasswordTextField: PaddingTextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var passwordRequirmentsLabel: UILabel!
    
    var newPasswordTextPublisher: AnyPublisher<String, Never>!
    var repeatPasswordPublisher: AnyPublisher<String, Never>!
    
    @LazyInjected var newPasswordViewModel: ForgetPasswordProccedureViewModel
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        newPasswordTextField.becomeFirstResponder()
        adjustLabelFont()
        setUpTextField()
        setUpBindings()
    }
    
    private func setUpBindings() {
        newPasswordTextPublisher = newPasswordTextField.textPublisher()
        repeatPasswordPublisher = repeatPasswordTextField.textPublisher()
        func bindViewToViewModel() {
            Publishers.CombineLatest(newPasswordTextPublisher, repeatPasswordPublisher)
                .sink {
                    if $0 == $1{
                        self.newPasswordViewModel.forgetPasswordCredentials.newPassword = $0
                        self.newPasswordViewModel.forgetPasswordCredentials.passwordsMatch = true
                    } else {
                        self.newPasswordViewModel.forgetPasswordCredentials.passwordsMatch = false
                    }
                }
                .store(in: &bindings)
        }
        
        
        func bindViewModelToView() {
            
            newPasswordViewModel.validationResult
                .sink { [weak self] receivedValue in
                    switch receivedValue {
                    case .success(()):
                        self?.errorMessageLabel.isHidden = true
                        self?.newPasswordViewModel.navigateToNextScene()
                    case .failure(let error):
                        self?.errorMessageLabel.text = error.message
                        self?.errorMessageLabel.isHidden = false
                        self?.passwordRequirmentsLabel.isHidden = true
                        break
                    }
                }
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    @IBAction func resetPasswordClicked() {
        newPasswordViewModel.validateForgotPasswordProccedure()
    }
    
    private func adjustLabelFont() {
        errorMessageLabel.font = UIFont.SanFranciscoLight(size: 14)
    }
    
    private func setUpTextField () {
        self.hideKeyboardWhenTappedAround()
        newPasswordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        newPasswordTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        repeatPasswordTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        newPasswordTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
        repeatPasswordTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
    }
}


extension NewPasswordController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resetPasswordClicked()
        return true
    }
}
