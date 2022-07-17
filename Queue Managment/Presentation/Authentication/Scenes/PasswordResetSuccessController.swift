//
//  PasswordResetSuccessController.swift
//  Queue Managment
//
//  Created by WINTAA on 27.06.22.
//

import Foundation
import UIKit
import Resolver
import Combine

class PasswordResetSuccess: UIViewController {
    
    @IBOutlet weak var passwordResetSuccessfulyLabel: UILabel!
    
    @LazyInjected private var passwordResetSuccessVIewModel: PasswordResetSuccessVIewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustFontSize()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func signInClicked() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func adjustFontSize(){
        passwordResetSuccessfulyLabel.adjustsFontSizeToFitWidth = true
    }
}
