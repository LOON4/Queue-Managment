//
//  UIView.swift
//  Queue Managment
//
//  Created by WINTAA on 28.06.22.
//

import Foundation
import UIKit

extension UIView{
    var globalPoint: CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    var globalFrame: CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
    
    var cornerRadius: CGFloat {
        set { self.layer.cornerRadius = newValue }
        get { self.layer.cornerRadius }
    }
}

