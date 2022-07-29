//
//  PartsRepository.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

protocol PartsRepository {
    func getPart(partID: Int,
                 completion: @escaping (Result<APIPart, ServerError>) -> Void)
}
