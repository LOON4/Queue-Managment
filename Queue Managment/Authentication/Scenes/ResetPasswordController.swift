//
//  ResetPasswordController.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 26.06.22.
//

import Foundation
import UIKit


class ResetPasswordController : UIViewController {
    
    
    @IBOutlet weak var emailAdressTextField: PaddingTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextField()
        setUpBarButton()
    }
    
    @objc
    private func backButtonClicked(){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonClicked() {
        LoginWireFrame.showCheckEmailScreen(for: self)
    }
    
    private func setUpTextField () {
        emailAdressTextField.becomeFirstResponder()
        emailAdressTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
    }
    
    private func setUpBarButton () {
        let backButton = UIButton(type: .custom)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        backButton.configuration = .navigationBarButtonTemplate()
        let leftItem1 = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = leftItem1
    }
    
}
