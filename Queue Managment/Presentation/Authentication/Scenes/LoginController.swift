//
//  LoginController.swift
//  Queue Managment
//
//  Created by WINTAA on 22.06.22.
//

import Foundation
import UIKit
import Resolver
import Combine

class LoginController: UIViewController {
        
    @IBOutlet weak var appNameLabel: UILabel!
    
    @IBOutlet weak var emailTextField: PaddingTextField!
    @IBOutlet weak var passwordTextField: PaddingTextField!
    
    @IBOutlet weak var keepMeSignIcon: CheckboxButton!
    
    @IBOutlet weak var signInButton: QueueButtonOne!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    private var loader: LoaderView!

    @LazyInjected private var loginViewModel: LoginViewModel
    private var bindings = Set<AnyCancellable>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupLoader()
        setUpBindings()
        adjustLabelFontSizes()
    }

    
    private func setUpBindings() {
        func bindViewToViewModel() {
            emailTextField.textPublisher()
                .receive(on: DispatchQueue.main)
                .assign(to: \.email, on: loginViewModel)
                .store(in: &bindings)
            
            passwordTextField.textPublisher()
                .receive(on: DispatchQueue.main)
                .assign(to: \.passcode, on: loginViewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            loginViewModel.$isLoading
                .sink { [weak self] receivedValue in
                    if receivedValue {
                        self?.loader.startLoader()
                    } else {
                        self?.loader.stopLoader()
                    }
                }
                .store(in: &bindings)
            
            loginViewModel.validationResult
                .sink { completion in
                    switch completion {
                    case .failure:
                        self.emailTextField.layer.borderColor = UIColor.red.cgColor
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] _ in
                    self?.navigateToProfile()
                }
                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    private func navigateToProfile(){
        loginViewModel.router.showLoggedInSuccessfully()
    }
    
    
    @IBAction func rememberMeClicked() {
        keepMeSignIcon.toggle()
    }
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        loginViewModel.router.showPasswordScreen()
    }
    
    @IBAction func signInButtonClicked() {
        loginViewModel.loginUser()
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
    
    private func setupLoader() {
        loader = LoaderView(view)
        loader.stopLoader()
    }
}
