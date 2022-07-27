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
