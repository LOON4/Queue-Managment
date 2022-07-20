//
//  RotatableView.swift
//  Queue Managment
//
//  Created by WINTAA on 20.07.22.
//

import Foundation
import UIKit

@IBDesignable class RotatableView: UIView {

    @objc @IBInspectable var rotationDegrees: Float = 0 {
        didSet {
            let angle = NSNumber(value: rotationDegrees / 180.0 * Float.pi)
            layer.setValue(angle, forKeyPath: "transform.rotation.z")
        }
    }
}
