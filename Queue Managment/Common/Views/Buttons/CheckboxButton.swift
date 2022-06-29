//
//  checkedBox.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 25.06.22.
//

import Foundation
import UIKit

class CheckboxButton: UIButton {
    var isChecked: Bool = true
    
    func toggle(){
        isChecked.toggle()
        if isChecked {
            if let image = UIImage(named: ImgK.checkedBox1) {
                self.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: ImgK.uncheckedBox1) {
                self.setImage(image, for: .normal)
            }
        }
    }
    
}
