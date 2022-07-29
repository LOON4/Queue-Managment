//
//  FetchPartRequestsUseCase.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation
import Resolver
import SwiftUI

protocol FetchPartRequestsUseCase {
    func fetchCurrentPartRequests(page: Int, pageSize: Int, completion: @escaping (Result<APIPageInfo<APIPartRequest>, ServerError>) -> Void)
}

class FetchPartRequestsUseCaseImpl: FetchPartRequestsUseCase {
    
    @LazyInjected private var partRequestRepo: PartRequestRepository
    
    func fetchCurrentPartRequests(page: Int, pageSize: Int, completion: @escaping (Result<APIPageInfo<APIPartRequest>, ServerError>) -> Void) {
        partRequestRepo.fetchCurrentPartRequests(page: page,
                                             pageSize: pageSize){ result in
            completion(result)
        }
    }
    
    
}
