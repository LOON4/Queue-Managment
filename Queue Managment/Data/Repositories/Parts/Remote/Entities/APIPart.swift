//
//  APIPart.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

class APIPart: Codable, PartEntity {
    let id: Int
    let partName: String
    let partDetails: String?
    let carManufacturer: String?
    let carModel: String?
    let carReleaseYear: String?
    let partType: String
    let price: Int
    let totalAmount: Int
    let serviceId: Int
    
    func part() -> Part {
        var car: Car? = nil
        if carManufacturer != nil || carModel != nil || carReleaseYear != nil {
            car = Car(carManufacturer: carManufacturer,
                      carModel: carModel, carReleaseYear: carReleaseYear)
        }
        return Part(partID: id,
                    partName: partName,
                    partDetails: partDetails,
                    car: car,
                    partType: PartType(rawValue: partType),
                    price: price, totalAmount: totalAmount, serviceID: serviceId)
    }
}
