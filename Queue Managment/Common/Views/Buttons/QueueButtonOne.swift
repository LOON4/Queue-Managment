//
//  RoundButton.swift
//  Queue Managment
//
//  Created by WINTAA on 29.06.22.
//

import Foundation
import UIKit

class QueueButtonOne: UIButton, NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = UIButton(frame: self.globalFrame!)
        copy.layer.cornerRadius = self.layer.cornerRadius
        copy.backgroundColor = self.backgroundColor
        copy.titleLabel?.textAlignment = .center
        copy.titleLabel?.font = self.titleLabel?.font
        return copy
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp(){
        self.backgroundColor = .systemBlue
        self.titleLabel?.font = UIFont.SanFranciscoSemibold(size: 17)
        self.layer.cornerRadius = 8
    }
    
    
}
