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
        if let image = UIImage(named: isChecked ? ImgK.checkedBox1 : ImgK.uncheckedBox1) {
            self.setImage(image, for: .normal)
        }
    }
    
}
