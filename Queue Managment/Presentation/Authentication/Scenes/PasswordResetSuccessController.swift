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
        //        navigationController?.popToRootViewController(animated: true)
        //        UIStoryboard(name: "MainTabbar",
        //                    bundle: .main).instantiateViewController(withIdentifier: "MainTabbarController")
        let mainStoryboard = UIStoryboard(name: "MainTabBar", bundle: Bundle.main)
           if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UIViewController {
               self.present(viewController, animated: true, completion: nil)
           }
    }
    
    private func adjustFontSize(){
        passwordResetSuccessfulyLabel.adjustsFontSizeToFitWidth = true
    }
}
