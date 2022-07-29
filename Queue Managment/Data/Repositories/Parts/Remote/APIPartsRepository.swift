//
//  APIPartsRepository.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

protocol APIPartsRepository: PartsRepository {
    
}

class APIPartsRepositoryImpl: APIPartsRepository {
    func getPart(partID: Int,
                 completion: @escaping (Result<APIPart, ServerError>) -> Void) {
        let partsService = PartByIDService(id: partID)
        partsService.execute(){ result in
            completion(result)
        }
    }
}
