//
//  HistoryViewController.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 18.07.22.
//

import Foundation
import UIKit



@IBDesignable class RotatableView: UIView {

    @objc @IBInspectable var rotationDegrees: Float = 0 {
        didSet {
//            print("Setting angle to \(rotationDegrees)")
            let angle = NSNumber(value: rotationDegrees / 180.0 * Float.pi)
            layer.setValue(angle, forKeyPath: "transform.rotation.z")
        }
    }
}




class HistoryViewController : UIViewController {
    
   
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var justView: RotatableView!
    @IBOutlet weak var viewWithBorder: RotatableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder()
        setLabel()
        navigationController?.navigationBar.tintColor = .black

        
        title = "History"
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)!, height: 800)
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
    
    
    
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let height: CGFloat = 500 //whatever height you want to add to the existing height
//        let bounds = self.navigationController!.navigationBar.bounds
//        self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
//
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let height = CGFloat(720)
//        self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
//    }
    
}
    

