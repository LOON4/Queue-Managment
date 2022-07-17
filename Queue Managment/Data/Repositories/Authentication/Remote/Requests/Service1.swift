//
//  Service1.swift
//  Queue Managment
//
//  Created by WINTAA on 02.07.22.
//

import Foundation

class Service1: RequestType {

    var serviceName: String
    var servicePrice: Double

    init(serviceName: String, servicePrice: Double){
        self.serviceName = serviceName
        self.servicePrice = servicePrice
    }

    typealias ResponseType = Service1Response
    var data: RequestData {
        get {
            var request = RequestData(path: "/client/ceo/services", baseURL: BaseURL.identity)
            request.params = ["serviceName" : serviceName, "servicePrice": servicePrice]
            request.method = .post
            return request
        }
    }
    
}

