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
    
    
    private func setUpTextField () {
        emailAdressTextField.becomeFirstResponder()
        emailAdressTextField.setPadding(padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0))
    }
    
    private func setUpBarButton () {
        let backButtom = UIButton(type: .system)
        backButtom.setTitle(" Back", for: .normal)
        
        let image = UIImage(systemName: "arrow.backward")
//        image = image?.withTintColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 1))
        
        backButtom.setImage(image, for: .normal)
//        backButtom.foreground
        
        backButtom.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let leftItem1 = UIBarButtonItem(customView: backButtom)
        
        self.navigationItem.leftBarButtonItem = leftItem1
    }
    
}
