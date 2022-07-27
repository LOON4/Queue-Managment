//
//  ResetPasswordCodeController.swift
//  Queue Managment
//
//  Created by WINTAA on 27.06.22.
//

import Foundation
import UIKit
import Resolver
import Combine

class ResetPasswordCodeController: UIViewController {
    
    @IBOutlet weak var codeTextField: PaddingTextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @LazyInjected var resetpasswordCodeViewmodel: ForgetPasswordProccedureViewModel
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustLabelFont()
        setUpTextField()
        setUpBindings()
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            codeTextField.textPublisher()
                .receive(on: DispatchQueue.main)
                .assign(to: \.forgetPasswordCredentials.code, on: resetpasswordCodeViewmodel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            
            resetpasswordCodeViewmodel.validationResult
                .sink { [weak self] receivedValue in
                    switch receivedValue {
                    case .success(()):
                        self?.errorMessageLabel.isHidden = true
                        self?.resetpasswordCodeViewmodel.navigateToNextScene()
                    case .failure(let error):
                        self?.errorMessageLabel.text = error.message
                        self?.errorMessageLabel.isHidden = false
                    }
                }
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    @IBAction func nextButtonClicked() {
        resetpasswordCodeViewmodel.validateForgotPasswordProccedure()
    }
    
    private func adjustLabelFont() {
        errorMessageLabel.font = UIFont.SanFranciscoLight(size: 14)
    }
    
    private func setUpTextField () {
        self.hideKeyboardWhenTappedAround()
        codeTextField.delegate = self
        codeTextField.becomeFirstResponder()
        codeTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
        codeTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
    }
    
}


extension ResetPasswordCodeController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextButtonClicked()
        return true
    }
}
