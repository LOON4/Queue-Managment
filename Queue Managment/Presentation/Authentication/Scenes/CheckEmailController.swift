//
//  CheckEmailController.swift
//  Queue Managment
//
//  Created by WINTAA on 26.06.22.
//

import Foundation
import UIKit
import Resolver
import Combine


class CheckEmailController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var checkYourEmailLabel: UILabel!
    @IBOutlet weak var emailSentLabel: UILabel!
    @IBOutlet weak var didNotreceiveCodeLabel: UILabel!
    
    @IBOutlet weak var openEmailButton: QueueButtonOne!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var resendCodeButton: UIButton!
    
    @LazyInjected private var checkEmailViewModel: CheckEmailViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        adjustLabelFont()
    }
    
    @IBAction func skipButtonClicked() {
        checkEmailViewModel.router.showCodeEnterSceen()
    }
    
    @IBAction func openEmailClicked() {
        let emailPresenter = EmailActionSheetPresenter()
        emailPresenter.presentingController = self
        present(emailPresenter.chooseEmailActionSheet, animated: true)
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
