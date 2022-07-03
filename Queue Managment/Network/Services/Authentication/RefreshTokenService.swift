//
//  RefreshTokenService.swift
//  Queue Managment
//
//  Created by WINTAA on 01.07.22.
//

import Foundation
import Alamofire

class RefreshTokenService: RequestType {
    
    var refreshToken: String
    
    init(refreshToken: String){
        self.refreshToken = refreshToken
    }
    
    typealias ResponseType = Token
    var data: RequestData {
        get {
            var request = RequestData(path: "/client/auth/refresh-token", baseURL: BaseURL.identity)
            request.params = ["refreshToken" : refreshToken]
            request.method = .post
            request.interceptor = nil
            request.session = Session.default
            return request
        }
    }

}
