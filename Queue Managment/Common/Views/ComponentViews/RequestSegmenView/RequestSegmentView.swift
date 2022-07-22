//
//  RequestSegmentView.swift
//  Queue Managment
//
//  Created by WINTAA on 22.07.22.
//

import Foundation
import UIKit

class RequestSegmentView: BasedComponentView {
    
    @IBOutlet var selectedView: [UIView]!
    @IBOutlet var buttonCollection: [UIButton]!
    
    var selectedIndex = 0
    
    override func setUp() {
        for (index, button) in buttonCollection.enumerated() {
            button.titleLabel?.font = UIFont.SanFranciscoLight(size: 14)
            //if index != selectedIndex {
                button.titleLabel?.textColor = UIColor(hex: "#262626", alpha: CGFloat(0.6))
            //}
        }
    }
    
    @IBAction func buttonClicked(button: UIButton) {
        let newIndex = buttonCollection.firstIndex(of: button)!
        
        self.buttonCollection[newIndex]
            .titleLabel?.textColor = UIColor(hex: "#262626")
        self.buttonCollection[self.selectedIndex]
            .titleLabel?.textColor = UIColor(hex: "#262626", alpha: CGFloat(0.6))
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.selectedView[newIndex].backgroundColor = .systemBlue
                self.selectedView[self.selectedIndex].backgroundColor = .clear
            },
            completion: {_ in
                self.selectedIndex = newIndex
            })
    }
    
}
