//
//  HistoryViewController.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 18.07.22.
//

import Foundation
import UIKit

class HistoryViewController : UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var justView: RotatableView!
    @IBOutlet weak var viewWithBorder: RotatableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder()
        setLabel()
        setUpBarButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setUpBarButton () {
        let backButton = UIButton(type: .custom)
        if let image = UIImage(named: "Bell_tabbar_item") {
            backButton.setImage(image, for: .normal)
        }
        
        let rightItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setBorder() {
        viewWithBorder.layer.borderWidth = 1.0
        viewWithBorder.layer.borderColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(120/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(0.44)).cgColor
    }
    
    func setLabel() {
        let range = NSRange(location:9,length:1)
        let attributedString = NSMutableAttributedString(string: "You have 0 requests at the moment.")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: CGFloat(0/255.0), green: CGFloat(122/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1)), range: range)
         label.attributedText = attributedString
    }    
}
    

