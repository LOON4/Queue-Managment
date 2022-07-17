//
//  StandardUserDefaults.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation

class StandardUserDefaults : UserDefaultsRepository {
    
    private let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case isSignedIn
        case isFirstLaunch
    }
    
    func setIsRemembered(remember: Bool) {
        UserDefaults.standard.set(remember, forKey: Key.isSignedIn.rawValue)
    }

    func isRemembered() -> Bool {
        return UserDefaults.standard.bool(forKey: Key.isSignedIn.rawValue)
    }
    
}
