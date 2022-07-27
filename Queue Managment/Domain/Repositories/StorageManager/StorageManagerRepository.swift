//
//  StorageManagerRepository.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

protocol StorageManagerRepository {
    func fetchGSMPartRequests(
        page: Int, pageSize: Int,
        completion: @escaping (Result<APIPageInfo<APIPartRequest>, ServerError>) -> Void)
}
