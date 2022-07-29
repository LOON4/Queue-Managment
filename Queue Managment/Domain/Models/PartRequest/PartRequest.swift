//
//  PartRequest.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation
import Combine

protocol PartRequestEntity: Codable {
    func partRequest() -> PartRequest
}

enum PartRequestStatus: String {
    case approvedBySM = "APPROVED_SM"
}

class PartRequest: CustomStringConvertible {
    var partRequestID: Int
    @Published var part: Part?
    var amount: Int
    var totalPrice: Int
    var status: PartRequestStatus
    var creationDate: Date
    
    
    init(partRequestID: Int,
         part: Part?,
         amount: Int,
         totalPrice: Int,
         status: PartRequestStatus,
         creationDate: Date){
        
        self.partRequestID = partRequestID
        self.part = part
        self.amount = amount
        self.totalPrice = totalPrice
        self.status = status
        self.creationDate = creationDate
    }
}
