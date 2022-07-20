//
//  NetworkLayer.swift
//  Queue Managment
//
//  Created by WINTAA on 30.06.22.
//
import Foundation
import Alamofire

protocol RequestType {
    associatedtype ResponseType: Decodable
    var data: RequestData { get }
}

extension RequestType {
    public func execute(completion: @escaping (Result<ResponseType, ServerError>) -> Void) {
        data.session!.request(
            data.url,
            method: data.method,
            parameters: data.params,
            encoding: JSONEncoding.default,
            headers: data.headers,
            interceptor: data.interceptor).validate(statusCode: -10000...10000).response { response in
                // no data or successful request but with no data
                guard let data = response.data else {
                    if response.response?.statusCode != 200 {
                        completion(.failure(ServerError(status: .networkFailure,
                                                    message: "Network Problem")))
                    } else {
                        let result = try! JSONDecoder().decode(ResponseType.self,
                                                               from: emptyJsonReply)
                        completion(.success(result))
                    }
                    return
                }
                
                // successful request
                if response.response?.statusCode == ResponseStatusCode.success.rawValue {
                    do {
                        let result = try JSONDecoder().decode(ResponseType.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(ServerError(status: .parsingFailure,
                                                        message: "Couldn't Parse Fetched Data")))
                    }
                // any other request status code
                } else {
                    let APIServerError = try? JSONDecoder().decode(APIServerError.self,
                                                                from: data)
                    completion(.failure(ServerError(APIServerError: APIServerError!)))
                    return
                }
            }
        }
}
    
