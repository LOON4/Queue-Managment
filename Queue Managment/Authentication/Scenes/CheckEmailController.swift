//
//  CheckEmailController.swift
//  Queue Managment
//
//  Created by WINTAA on 26.06.22.
//

import Foundation
import UIKit

class CheckEmailController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var checkYourEmailLabel: UILabel!
    @IBOutlet weak var emailSentLabel: UILabel!
    @IBOutlet weak var didNotreceiveCodeLabel: UILabel!
    
    @IBOutlet weak var openEmailButton: QueueButtonOne!
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
    
    @IBAction func openEmailClicked() {
        let mailURL = URL(string: "message://")!
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
         }
        LoginWireFrame.showCodeEnterSceen(for: self)
    }
    
    private func adjustLabelFont () {
        openEmailButton.titleLabel?.font = UIFont.SanFranciscoSemibold(size: 17)
        skipButton.titleLabel?.font = UIFont.SanFranciscoSemibold(size: 17)
        didNotreceiveCodeLabel.font = UIFont.SanFranciscoSemibold(size: 17)
        
        checkYourEmailLabel.font = UIFont.SanFranciscoBold(size: 36)
        emailSentLabel.font = UIFont.SanFranciscoRegular(size: 17)
        checkYourEmailLabel.adjustsFontSizeToFitWidth = true
        emailSentLabel.adjustsFontSizeToFitWidth = true
    }
}
