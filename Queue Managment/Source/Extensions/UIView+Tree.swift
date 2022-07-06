//
//  UIView+Tree.swift
//  BasisCommon
//
//  Created by Andrej Slegl on 12/03/2021.
//

import Foundation
import UIKit

public extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let current = parentResponder {
            parentResponder = current.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }

        return nil
    }
    
    func firstView<T>(ofType: T.Type = T.self) -> T? {
        if let view = self as? T {
            return view
        }
        
        return subviews.lazy.compactMap { $0.firstView(ofType: ofType) }.first
    }
    
    func firstView(where selector: (UIView) -> Bool) -> UIView? {
        if selector(self) {
            return self
        }
        
        for view in subviews {
            if let first = view.firstView(where: selector) {
                return first
            }
        }
        
        return nil
    }
}
