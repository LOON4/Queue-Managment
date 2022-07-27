//
//  ReusableCell.swift
//  Queue Managment
//
//  Created by WINTAA on 25.07.22.
//

import Foundation

protocol ReusableCell {
    static var reuseID: String { get }
}

extension ReusableCell {
    static var reuseID: String {
        return String(describing: self)
    }
}
