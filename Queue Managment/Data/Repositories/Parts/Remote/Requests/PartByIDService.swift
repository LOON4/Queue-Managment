//
//  PartByIDService.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

class PartByIDService: RequestType {
    var id: Int

    init(id: Int){
        self.id = id
    }

    typealias ResponseType = APIPart
    var data: RequestData {
        get {
            let path = "/storage/part/get/\(id)"
            var request = RequestData(path: path)
            request.method = .get
            return request
        }
    }
}
