//
//  NetworkRequest.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
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

struct NoReply: Decodable {}
let emptyJsonReply = "{}".data(using: .utf8)!

enum ResponseStatusCode: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
}

struct RequestData {

    static let sharedSession = Session()
    static let sharedInterceptor: AuthenticationInterceptor<OAuthAuthenticator> = {
        let credential = OAuthCredential(token: Token.shared)
        let authenticator = OAuthAuthenticator()
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        return interceptor
    }()

    var session: Session? = RequestData.sharedSession
    var interceptor: AuthenticationInterceptor<OAuthAuthenticator>? = RequestData.sharedInterceptor
    
    let path: String
    let baseURL: String
    var method: Alamofire.HTTPMethod
    var params: [String: Any]?
    var arrayParams: [Any]?
    var headers: HTTPHeaders?

    
    var url: String {
        get {
            return baseURL.appending(path)
        }
    }

    init(path: String,
         baseURL: String = BaseURL.identity,
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
