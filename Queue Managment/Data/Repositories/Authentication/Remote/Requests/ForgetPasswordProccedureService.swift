//
//  ForgetPasswordProccedureService.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 19.07.22.
//

import Foundation
import SwiftUI
import RxCocoa

enum ForgetPasswordProccedureStage: Int {
    case checkEmail = 0
    case checkCode
    case checkPassword
    
    func endPoint() -> String {
        switch self {
        case .checkEmail:
            return "/send-reset-code"
        case .checkCode:
            return "/send-reset-code"
        case .checkPassword:
            return "/reset-password"
        }
    }
    
    func params(_ forgetPasswordCredentials: ForgetPasswordCredentials) -> [String : Any] {
        var params = [String : Any]()
        
        switch self {
        case .checkPassword:
            params["newPassword"] = forgetPasswordCredentials.newPassword
            fallthrough
        case .checkCode:
            params["code"] = forgetPasswordCredentials.code
            fallthrough
        case .checkEmail:
            params["email"] = forgetPasswordCredentials.email
        }
        return params
    }
    
}

class ForgetPasswordProccedureService: RequestType {
    
    var forgetPasswordCredentials: ForgetPasswordCredentials
    var currentStage: ForgetPasswordProccedureStage
    
    init(_ forgetPasswordCredentials: ForgetPasswordCredentials,
         _ stage : ForgetPasswordProccedureStage) {
        self.forgetPasswordCredentials = forgetPasswordCredentials
        self.currentStage = stage
    }

    typealias ResponseType = NoReply

    var data: RequestData  {
        get {
            var request = RequestData(path: "/client/auth" + currentStage.endPoint())
            request.params = currentStage.params(forgetPasswordCredentials)
            request.method = .post
            return request
        }
    }
    
}
