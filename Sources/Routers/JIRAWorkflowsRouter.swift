//
//  JIRAWorkflowsRouter.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

struct JIRAWorkflowsRouter: URLRequestConvertible {
    
    enum Action {
        case getAllWorkflows(params: Parameters?)
        case getProperties(transitionId: String, params: Parameters?)
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
        case .getAllWorkflows(let params):
            method = .get
            if let params = params {
                parameters = params
            }
        case .getProperties(let transitionId, let params):
            method = .get
            relativePath = "transitions/\(transitionId)/properties"
            parameters = params
        }
        
        let url: URL = {
            var url = URL(string: "\(jiraBaseURL)/workflow")!
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



