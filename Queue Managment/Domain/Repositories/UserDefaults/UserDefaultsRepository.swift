//
//  UserDefaultsRepository.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation

protocol UserDefaultsRepository {
    func setIsRemembered(remember: Bool)
    func isRemembered() -> Bool
}
