//
//  UserSessionDataStore.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation
import SwiftKeychainWrapper

protocol UserSessionDataStore {
    func setToken(token: Token)
    func unsetToken()
    func getToken() -> Token?
}

class KeyChainUserSession : UserSessionDataStore {
    
    enum Key: String {
        case token
    }
    
    let keychain = KeychainWrapper.standard
    
    func setToken(token: Token) {
        KeychainWrapper.standard.set(token, forKey: Key.token.rawValue)
    }
    
    func unsetToken() {
        KeychainWrapper.standard.removeObject(forKey: Key.token.rawValue)
    }
    
    func getToken() -> Token?{
        KeychainWrapper.standard.object(forKey: Key.token.rawValue) as? Token
    }
}
