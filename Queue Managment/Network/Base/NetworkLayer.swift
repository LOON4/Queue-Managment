//
//  NetworkLayer.swift
//  Queue Managment
//
//  Created by WINTAA on 30.06.22.
//

import Foundation
import Alamofire

struct BaseURL {
    static let identity = "http://3.124.197.161:8000"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ResponseStatusCode: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
}

struct RequestData {

    static let sharedSession = Session()
    static let sharedInterceptor: AuthenticationInterceptor<OAuthAuthenticator> = {
        let credential = OAuthCredential(token: AccountManager.shared.token)
        let authenticator = OAuthAuthenticator()
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        return interceptor
    }()
    
    
    let path: String
    let baseURL: String
    var method: Alamofire.HTTPMethod
    var params: [String: Any]?
    var arrayParams: [Any]?
    var headers: HTTPHeaders?
    var session: Session? = RequestData.sharedSession
    var interceptor: AuthenticationInterceptor<OAuthAuthenticator>? = RequestData.sharedInterceptor
    
    var url: String {
        get {
            return baseURL.appending(path)
        }
    }

    init(path: String,
         baseURL: String,
         method: Alamofire.HTTPMethod = .post,
         params: [String: Any]? = nil,
         arrayParams: [Any]? = nil,
         headers: HTTPHeaders = ["Content-Type": "application/json"]
    ) {
        self.path = path
        self.baseURL = baseURL
        self.method = method
        self.params = params
        self.arrayParams = arrayParams
        self.headers = headers
    }
}


protocol RequestType: RequestInterceptor {
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
                //defer {  SplashScreenController.showFirstScreenSemaphore.signal() }
                guard let data = response.data else {
                    completion(.failure(ServerError(status: "Unknown", message: "No Data")))
                    return
                }
         
                if response.response?.statusCode == ResponseStatusCode.badRequest.rawValue {
                    let serverError = try? JSONDecoder().decode(ServerError.self, from: data)
                    completion(.failure(serverError!))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ResponseType.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(ServerError(status: "meore gaguebari", message: "No Data")))
                }
            }
        }
}
    
