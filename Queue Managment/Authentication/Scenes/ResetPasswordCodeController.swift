//
//  ResetPasswordCodeController.swift
//  Queue Managment
//
//  Created by WINTAA on 27.06.22.
//

import Foundation
import UIKit

class ResetPasswordCodeController: UIViewController {
    @IBOutlet weak var codeTextField: PaddingTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextField()
    }
    

    @IBAction func nextButtonClicked() {
        LoginWireFrame.showNewPasswordScreen(for: self)
    }
    
    private func setUpTextField () {
        codeTextField.becomeFirstResponder()
        codeTextField.setPlaceholderFont(color: .myLightBlack, font: .SanFranciscoLight(size: 17)!)
        codeTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
    }
        
}
