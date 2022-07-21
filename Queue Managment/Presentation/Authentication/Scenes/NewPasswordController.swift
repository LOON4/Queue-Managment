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
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        newPasswordTextField.becomeFirstResponder()
        setUpTextField()
        setUpBindings()
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            newPasswordTextField.textPublisher()
                .receive(on: DispatchQueue.main)
                .assign(to: \.newPasswordTextField, on: newPasswordViewModel)
                .store(in: &bindings)
            
            repeatPasswordTextField.textPublisher()
                .receive(on: DispatchQueue.main)
                .assign(to: \.repeatPasswordTextField, on: newPasswordViewModel)
                .store(in: &bindings)
        }
        
        
        func bindViewModelToView() {
            
            newPasswordViewModel.validationResult
                .sink { [weak self] receivedValue in
                    switch receivedValue {
                    case .success(()):
//                        self?.errorMessageLabel.isHidden = true
                        self?.newPasswordViewModel.navigateToPasswordResecSucces()
                    case .failure(let error):
//                        self?.errorMessageLabel.text = error.message
//                        self?.errorMessageLabel.isHidden = false
                        break
                    }
                }
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    @IBAction func resetPasswordClicked() {
        newPasswordViewModel.checkPassword()
    }
    
    private func setUpTextField () {
        newPasswordTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        repeatPasswordTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        newPasswordTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
        repeatPasswordTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
    }
}
