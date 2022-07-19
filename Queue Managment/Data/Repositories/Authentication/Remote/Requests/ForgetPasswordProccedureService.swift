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
}

class ForgetPasswordProccedureService: RequestType {

    let endPoints = ["/send-reset-code",
                     "​/check-code",
                     "/reset-password"]
    
    var forgetPasswordCredentials: ForgetPasswordCredentials
    var currentStage: ForgetPasswordProccedureStage
    
    init(_ forgetPasswordCredentials: ForgetPasswordCredentials,
         _ stage : ForgetPasswordProccedureStage) {
        self.forgetPasswordCredentials = forgetPasswordCredentials
        self.currentStage = stage
    }

    typealias ResponseType = Bool

    var data: RequestData  {
        get {
            var request = RequestData(path: "/client/auth" + endPoints[currentStage.rawValue])
            request.params = ["email": forgetPasswordCredentials.email]
            request.method = .post
            return request
        }
    }
    
}
