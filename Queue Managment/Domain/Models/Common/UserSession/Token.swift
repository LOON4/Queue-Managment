//
//  Token.swift
//  Queue Managment
//
//  Created by WINTAA on 30.06.22.
//

import Foundation

class Token: NSObject, NSCoding {
    
    static var shared: Token? {
        didSet {
            RequestData.sharedInterceptor.credential?.token = shared
        }
    }
    
    let accessToken: String
    let expiresIn: Int
    var refreshToken: String
    let refreshTokenExpirein: Int
    var expiringDate: Date
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpirein = "refresh_token_expires_in"
        case expiringDate = "expiring_date"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(accessToken, forKey: CodingKeys.accessToken.rawValue)
        coder.encode(expiresIn, forKey: CodingKeys.expiresIn.rawValue)
        coder.encode(refreshToken, forKey: CodingKeys.refreshToken.rawValue)
        coder.encode(refreshTokenExpirein, forKey: CodingKeys.refreshTokenExpirein.rawValue)
        coder.encode(expiringDate, forKey: CodingKeys.expiringDate.rawValue)

    }
    
    required init?(coder: NSCoder) {
        self.accessToken = coder.decodeObject(forKey: CodingKeys.accessToken.rawValue) as! String
        self.expiresIn = Int(coder.decodeCInt(forKey: CodingKeys.expiresIn.rawValue))
        self.refreshToken = coder.decodeObject(forKey: CodingKeys.refreshToken.rawValue) as! String
        self.refreshTokenExpirein = Int(coder.decodeCInt(forKey: CodingKeys.refreshTokenExpirein.rawValue))
        self.expiringDate = coder.decodeObject(forKey: CodingKeys.expiringDate.rawValue) as! Date

    }
    
    init(_ APIToken: APIToken){
        self.accessToken = APIToken.accessToken
        self.expiresIn = APIToken.expiresIn
        self.refreshToken = APIToken.refreshToken
        self.refreshTokenExpirein = APIToken.refreshTokenExpirein
        self.expiringDate = Date(timeIntervalSinceNow: TimeInterval(APIToken.expiresIn))
    }
    
    func decodeToken() -> [String: Any]? {
        func base64Decode(_ base64: String) -> Data? {
            let padded = base64.padding(toLength: ((base64.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
            guard let decoded = Data(base64Encoded: padded) else { return nil }
            return decoded
        }
        
        func decodeJWTPart(_ value: String) -> [String: Any]? {
            guard let bodyData = base64Decode(value) else { return nil }
            let json = try? JSONSerialization.jsonObject(with: bodyData, options: [])
            guard let payload = json as? [String: Any] else { return nil }
            return payload
        }
        
        let jwtToken = self.accessToken
        
        let segments = jwtToken.components(separatedBy: ".")
        return decodeJWTPart(segments[1])
    }
 
}
