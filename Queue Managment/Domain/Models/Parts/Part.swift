//
//  Part.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

protocol PartEntity: Codable {
    func part() -> Part
}

enum PartType: String {
    case core = "CORE"
    case tire = "TIRE"
    case electronics = "ELECTRONICS"
    case other = "OTHER"
}

class Part: CustomStringConvertible {
    var partID: Int
    var partName: String
    var partDetails: String?
    var car: Car?
    var partType: PartType?
    var price: Int
    var totalAmount: Int
    var serviceID: Int
    
    init(partID: Int,
         partName: String = "",
         partDetails: String? = nil,
         car: Car? = nil,
         partType: PartType? = nil,
         price: Int = 0,
         totalAmount: Int = 0,
         serviceID: Int = 0){
        
        self.partID = partID
        self.partName = partName
        self.partDetails = partDetails
        self.partType = partType
        self.price = price
        self.totalAmount = totalAmount
        self.serviceID = serviceID

    }
}
