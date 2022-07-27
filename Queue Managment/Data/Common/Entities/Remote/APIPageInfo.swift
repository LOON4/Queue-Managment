//
//  APIPageInfo.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

class APIPageInfo<T: Codable>: Codable {
    var content: [T]
    var pageable: APIPageable
    var totalPages: Int
}

class APIPageable: Codable {
    var pageNumber: Int
}
