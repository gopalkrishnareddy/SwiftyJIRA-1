//
//  JIRASearchRouter.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/29/17.
//

import Foundation
import Alamofire

struct JIRASearchRouter: URLRequestConvertible {
    
    enum Action {
        case searchUsingSearchRequest(request: String)
        case search(params: Parameters)
    }
    
    let user: String
    let password: String
    let action: Action
    
    func asURLRequest() throws -> URLRequest {
        var relativePath: String?
        let method: HTTPMethod
        var parameters: Parameters?
        var bodyData: Data?
        
        switch self.action {
        case .searchUsingSearchRequest(let request):
            method = .post
            bodyData = try JSONEncoder().encode(request)
        case .search(let params):
            method = .get
            parameters = params
        }
        
        let url: URL = {
            var url = URL(string: "\(jiraBaseURL)/rest/api/2/search")!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            urlRequest.setValue(authorizationHeader.value, forHTTPHeaderField: authorizationHeader.key)
        }
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        var request = try encoding.encode(urlRequest, with: parameters)
        if let bodyData = bodyData {
            request.httpBody = bodyData
        }
        return request
    }
}




