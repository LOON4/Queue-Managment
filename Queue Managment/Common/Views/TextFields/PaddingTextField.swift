//
//  PaddingTextField.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 25.06.22.
//

import Foundation
import UIKit

class PaddingTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    func setPadding (padding: UIEdgeInsets) {
        self.padding = padding
    }
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
}
