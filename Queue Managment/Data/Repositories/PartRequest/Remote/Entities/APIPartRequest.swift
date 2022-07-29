//
//  APIPartRequest.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

class APIPartRequest: Codable, PartRequestEntity {
    
    let partRequestID, partID, amount, totalPrice: Int
    let status, createdAt: String

    enum CodingKeys: String, CodingKey {
        case partRequestID = "partRequestId"
        case partID = "partId"
        case amount, totalPrice, status, createdAt
    }
    
    func partRequest() -> PartRequest {
        PartRequest(partRequestID: partRequestID,
                           part: Part(partID: partID),
                           amount: amount,
                           totalPrice: totalPrice,
                           status: PartRequestStatus.init(rawValue: status)!,
                           creationDate: createdAt.toDate(using: .toMillis)!)
    }
}
