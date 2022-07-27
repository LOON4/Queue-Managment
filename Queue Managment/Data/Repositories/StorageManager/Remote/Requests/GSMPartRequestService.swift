//
//  GSMPartRequestService.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

class GSMPartRequestService: RequestType {
    var page: Int
    var pageSize: Int

    init(page: Int, pageSize: Int){
        self.page = page
        self.pageSize = pageSize
    }

    typealias ResponseType = APIPageInfo<APIPartRequest>
    var data: RequestData {
        get {
            let path = "/storage/part-request/get-gsm?\(page)&size=\(pageSize)"
            var request = RequestData(path: path)
            request.method = .get
            return request
        }
    }
}
