//
//  PartRequest.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

protocol PartRequestEntity: Codable {
    func partRequest() -> PartRequest
}

enum PartRequestStatus: String {
    case approvedBySM = "APPROVED_SM"
}

class PartRequest {
    var partRequestID: Int
    var partID: Int
    var amount: Int
    var totalPrice: Int
    var status: PartRequestStatus
    var creationDate: Date
    
    
    init(partRequestID: Int,
         partID: Int,
         amount: Int,
         totalPrice: Int,
         status: PartRequestStatus,
         creationDate: Date){
        
        self.partRequestID = partRequestID
        self.partID = partID
        self.amount = amount
        self.totalPrice = totalPrice
        self.status = status
        self.creationDate = creationDate
    }
}
