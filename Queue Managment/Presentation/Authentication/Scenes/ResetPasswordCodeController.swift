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
    
    @LazyInjected var resetpasswordCodeViewmodel: ResetpasswordCodeViewmodel
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                        self?.resetpasswordCodeViewmodel.navigateToEnterNewPassword()
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
        resetpasswordCodeViewmodel.checkCode()
    }
    
    private func setUpTextField () {
        codeTextField.becomeFirstResponder()
        codeTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
        codeTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
    }
    
}
