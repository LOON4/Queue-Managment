//
//  UIView+LayoutPriorityConvenience.swift
//  BasisCommon
//
//  Created by Andrej Slegl on 09/06/2021.
//

import Foundation
import UIKit

public extension UIView {
    @discardableResult
    func withContentCompResistanceRequired(for axis: NSLayoutConstraint.Axis) -> Self {
        return withContentCompResistance(priority: .required, for: axis)
    }
    
    @discardableResult
    func withContentHuggingRequired(for axis: NSLayoutConstraint.Axis) -> Self {
        return withContentHugging(priority: .required, for: axis)
    }
    
    @discardableResult
    func withContentCompResistance(priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
    
    @discardableResult
    func withContentHugging(priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        setContentHuggingPriority(priority, for: axis)
        return self
    }
}
