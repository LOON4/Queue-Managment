//
//  LoginServices.swift
//  Queue Managment
//
//  Created by WINTAA on 30.06.22.
//

import Foundation

class LoginService: RequestType {
    var email: String
    var password: String
    var rememberMe: Bool

    init(email: String, password: String, rememberMe: Bool) {
        self.email = email
        self.password = password
        self.rememberMe = rememberMe
    }

    typealias ResponseType = APIToken
    var data: RequestData {
        get {
            var request = RequestData(path: "/client/auth/login")
            request.params = ["email" : email, "password" : password, "rememberme" : rememberMe]
            request.method = .post
            return request
        }
    }
}
