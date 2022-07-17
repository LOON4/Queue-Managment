//
//  ResetPasswordController.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 26.06.22.
//

import Foundation
import UIKit
import Resolver
import Combine

class ResetPasswordController : UIViewController {
    
    @IBOutlet weak var emailAdressTextField: PaddingTextField!
    @IBOutlet weak var nextButton: QueueButtonOne!
    
    private let buttonLoweringAnimator = BackgroundFadeButtonLoweringAnimator()
    
    @LazyInjected private var resetPasswordViewModel: ResetPasswordViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        setUpTextField()
        setUpBarButton()
        setUpButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsetDelegates()
    }
    
    private func unsetDelegates(){
        navigationController?.delegate = nil
    }
    
    private func setUpDelegates(){
        navigationController?.delegate = self
    }
    
    @objc
    private func backButtonClicked(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonClicked() {
        resetPasswordViewModel.router.showCheckEmailScreen()
    }
    
    private func setUpTextField () {
        emailAdressTextField.becomeFirstResponder()
        emailAdressTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
        emailAdressTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
    }
    
    private func setUpBarButton () {
        let backButton = UIButton(type: .custom)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        backButton.configuration = .navigationBarButtonTemplate()
        let leftItem1 = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = leftItem1
    }
    
    private func setUpButton(){
        nextButton.cornerRadius = 8
    }
    
}

extension ResetPasswordController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let _ = toVC as? CheckEmailController {
            return buttonLoweringAnimator
        } else {
            return nil
        }
    }
}
