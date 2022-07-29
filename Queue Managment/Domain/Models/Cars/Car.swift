//
//  Car.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

protocol CarEntity: Codable {
    func part() -> Part
}


class Car {
    var carID: Int
    var carManufacturer: String?
    var carModel: String?
    var carReleaseYear: String?
    
    
    init(carID: Int = 0,
         carManufacturer: String? = nil,
         carModel: String? = nil,
         carReleaseYear: String? = nil){
        
        self.carID = carID
        self.carManufacturer = carManufacturer
        self.carModel = carModel
        self.carReleaseYear = carReleaseYear
    }
}
