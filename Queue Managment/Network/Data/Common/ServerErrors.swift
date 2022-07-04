//
//  ServerErros.swift
//  Queue Managment
//
//  Created by WINTAA on 30.06.22.
//

import Foundation

struct ServerError: Codable, Error {
    let status: String
    let message: String
}
