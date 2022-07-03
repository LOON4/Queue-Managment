//
//  Token.swift
//  Queue Managment
//
//  Created by WINTAA on 30.06.22.
//

import Foundation

class Token: NSObject, Codable, NSCoding {
    let accessToken: String
    let expiresIn: Int
    var refreshToken: String
    let refreshTokenExpirein: Int
    var expiringDate: Date? = {
        Date(timeIntervalSinceNow: TimeInterval(300))
    }()
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpirein = "refresh_token_expires_in"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(accessToken, forKey: CodingKeys.accessToken.rawValue)
        coder.encode(expiresIn, forKey: CodingKeys.expiresIn.rawValue)
        coder.encode(refreshToken, forKey: CodingKeys.refreshToken.rawValue)
        coder.encode(refreshTokenExpirein, forKey: CodingKeys.refreshTokenExpirein.rawValue)

    }
    
    required init?(coder: NSCoder) {
        self.accessToken = coder.decodeObject(forKey: CodingKeys.accessToken.rawValue) as! String
        self.expiresIn = Int(coder.decodeCInt(forKey: CodingKeys.expiresIn.rawValue))
        self.refreshToken = coder.decodeObject(forKey: CodingKeys.refreshToken.rawValue) as! String
        self.refreshTokenExpirein = Int(coder.decodeCInt(forKey: CodingKeys.refreshTokenExpirein.rawValue))
    }
}
