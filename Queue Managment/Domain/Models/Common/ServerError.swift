//
//  MyServerError.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation

struct ServerError: Error {
    
    enum MyStatusCode: Int, Codable {
        case success = 200
        case badRequest = 400
        case unauthorized = 401
        case networkFailure = 2001
        case parsingFailure = 2002
        case localRefreshTokenDoesntExist = 2003
        case unknown
    }
    
    let status: MyStatusCode
    var message: String
    
    init(status: MyStatusCode, message: String){
        self.status = status
        self.message = message
        fixErrorMessage()
    }
    
    init(APIServerError: APIServerError){
        self.status = MyStatusCode(rawValue: Int(APIServerError.status)!) ?? .unknown
        self.message = APIServerError.message
        fixErrorMessage()
    }
    
    private mutating func fixErrorMessage(){
        self.message = self.message.components(separatedBy: "/n").joined(separator: "\n")
    }
    
}
