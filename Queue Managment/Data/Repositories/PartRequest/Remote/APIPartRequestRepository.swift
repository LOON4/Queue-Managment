//
//  APIStorageManagerRepository.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

protocol APIPartRequestRepository: PartRequestRepository {
    
}

class APIPartRequestRepositoryImp: PartRequestRepository{
    func fetchCurrentPartRequests(page: Int, pageSize: Int, completion: @escaping (Result<APIPageInfo<APIPartRequest>, ServerError>) -> Void) {
        let fetchPartRequestService = CurrentPartRequestService(page: page,
                                                                pageSize: pageSize)
        fetchPartRequestService.execute(){ result in
            completion(result)
        }
    }
}
