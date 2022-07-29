//
//  GetPart.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation
import Resolver

protocol GetPartsUseCase {
    func getPart(partID: Int,
                 completion: @escaping (Result<APIPart, ServerError>) -> Void)
}

class GetPartsUseCaseImpl: GetPartsUseCase {
    
    @LazyInjected private var partRequestRepo: PartsRepository
    
    func getPart(partID: Int,
                 completion: @escaping (Result<APIPart, ServerError>) -> Void) {
        partRequestRepo.getPart(partID: partID){ result in
            completion(result)
        }
    }
}
