//
//  UIStackView+Convenience.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 04.07.22.
//

import UIKit

public extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis = .vertical,
                     distribution: Distribution = .fill,
                     alignment: Alignment = .fill,
                     spacing: CGFloat = 0,
                     arrangedSubviews: [UIView]? = nil) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        
        if let subviews = arrangedSubviews {
            subviews.forEach { addArrangedSubview($0) }
        }
    }
    
    func removeAllArrangedSubviews() {
        for subview in arrangedSubviews {
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    func addArranged(subview: UIView, spacingBellow: CGFloat) {
        addArrangedSubview(subview)
        setCustomSpacing(spacingBellow, after: subview)
    }
}
