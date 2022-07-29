//
//  String.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

enum DateFormatterFormat: String {
    case toMillis = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
}

extension String {
    func toDate(using format: DateFormatterFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
}

extension CustomStringConvertible {
    var description : String {
        var description: String = ""
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}
