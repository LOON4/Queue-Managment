//
//  PageInfo.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

class PageInfo<T> {
    var content: [T]
    var page: Int
    var totalPages: Int
    
    public init(content: [T], page: Int, totalPages: Int) {
        self.content = content
        self.page = page
        self.totalPages = totalPages
    }
}
