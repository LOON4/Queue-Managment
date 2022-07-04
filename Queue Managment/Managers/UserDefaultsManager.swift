//
//  UserDefaultsManager.swift
//  Queue Managment
//
//  Created by WINTAA on 02.07.22.
//

import Foundation
import SwiftKeychainWrapper

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private init() {}
    
    let keychain = KeychainWrapper.standard

    enum Key: String {
        case token
        case isSignedIn
        case email
        case isFirstLaunch
    }
    
    var isFirstLaunch: Bool {
        UserDefaults.standard.bool(forKey: Key.isFirstLaunch.rawValue)
    }
    
    func setIsRemembered(remember: Bool) {
        UserDefaults.standard.set(remember, forKey: Key.isSignedIn.rawValue)
    }

    func isRemembered() -> Bool {
        return UserDefaults.standard.bool(forKey: Key.isSignedIn.rawValue)
    }
    
    func setToken(token: Token) {
        KeychainWrapper.standard.set(token, forKey: Key.token.rawValue)
    }
    
    func unsetToken() {
        KeychainWrapper.standard.removeObject(forKey: Key.token.rawValue)
    }
    
    func getToken() -> Token?{
        KeychainWrapper.standard.object(forKey: Key.token.rawValue) as? Token
    }
    
    func setEmail(email: String){
        KeychainWrapper.standard.set(email, forKey: Key.email.rawValue)
    }
    
    func unsetEmail(){
        KeychainWrapper.standard.removeObject(forKey: Key.email.rawValue)
    }
    
    func getEmail() -> String? {
        KeychainWrapper.standard.object(forKey: Key.email.rawValue) as? String
    }
    
}
