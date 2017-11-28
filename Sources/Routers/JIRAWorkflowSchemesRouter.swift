//
//  JIRAWorkflowSchemesRouter.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

struct JIRAWorkflowSchemesRouter: URLRequestConvertible {
    
    enum Action {
        case getById(id: Int, params: Parameters)
        case getIssueType(id: Int, issueType: String, params: Parameters)
        case getWorkflow(id: Int, params: Parameters)
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
        case .getById(let id, let params):
            method = .get
            relativePath = "\(id)"
            parameters = params
        case .getIssueType(let id, let issueType, let params):
            method = .get
            relativePath = "\(id)/issuetype/\(issueType)"
            parameters = params
        case .getWorkflow(let id, let params):
            method = .get
            relativePath = "\(id)/workflow"
            parameters = params
        }
        
        let url: URL = {
            var url = URL(string: "\(jiraBaseURL)/rest/api/2/workflowscheme")!
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




