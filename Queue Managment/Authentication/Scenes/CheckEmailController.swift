//
//  CheckEmailController.swift
//  Queue Managment
//
//  Created by WINTAA on 26.06.22.
//

import Foundation
import UIKit

class CheckEmailController: UIViewController {
    
    @IBOutlet weak var checkYourEmailLabel: UILabel!
    @IBOutlet weak var emailSentLabel: UILabel!
    
    @IBOutlet weak var openEmailButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var resendCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        adjustLabelFont()
    }
    
    @IBAction func skipButtonClicked() {
        LoginWireFrame.showCodeEnterSceen(for: self)
    }
    
    @IBAction func openEmailClicked(_ sender: Any) {
        LoginWireFrame.showCodeEnterSceen(for: self)
    }
    
    private func adjustLabelFont () {
        openEmailButton.titleLabel?.font = UIFont.SanFranciscoSemibold(size: 17)
        skipButton.titleLabel?.font = UIFont.SanFranciscoSemibold(size: 17)
        
        checkYourEmailLabel.font = UIFont.SanFranciscoBold(size: 36)
        emailSentLabel.font = UIFont.SanFranciscoRegular(size: 17)
        checkYourEmailLabel.adjustsFontSizeToFitWidth = true
        emailSentLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    
}
