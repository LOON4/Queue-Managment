//
//  AuthenticationError.swift
//  Queue Managment
//
//  Created by WINTAA on 21.07.22.
//

import Foundation

struct AuthenticationError: Error {
    var message: String
    var passwordError: String = ""
    var mailError: String = ""
    
    init(_ message: String){
        self.message = message
        stylizeErrorMessage()
    }
    
    private mutating func stylizeErrorMessage(){
        self.message.components(separatedBy: "\n").forEach {
            if $0.contains("mail") {
                mailError += $0
            } else {
                passwordError += $0
            }
        }
    }
}
