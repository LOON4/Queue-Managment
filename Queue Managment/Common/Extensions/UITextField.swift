//
//  UITextField+extension.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 23.06.22.
//

import Foundation
import UIKit


extension UITextField {
    

    
    func setPlaceholderFont(color: UIColor, font: UIFont){
        var placeholderAttributes = [NSAttributedString.Key: AnyObject]()
        placeholderAttributes[.foregroundColor] = color
        placeholderAttributes[.font] = font
        if let placeholder = self.placeholder {
            let newAttributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
            self.attributedPlaceholder = newAttributedPlaceholder
        }
    }
    
}
