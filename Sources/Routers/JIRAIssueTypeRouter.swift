//
//  JIRAIssueTypeRouter.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

struct JIRAIssueTypeRouter: URLRequestConvertible {
    
    enum Action {
        case getAllIssueTypes
        case createIssueType(body: JIRACreateIssueTypeBody)
        case getIssueType(id: String)
        case deleteIssueType(id: String, params: Parameters)
        case updateIssueType(id: String)
        case getAlternativeIssueTypes(id: String)
        case createAvatar(id: String, params: Parameters)
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
        case .getAllIssueTypes:
            method = .get
        case .createIssueType(let body):
            method = .post
            bodyData = try JSONEncoder().encode(body)
        case .getIssueType(let id):
            method = .get
            relativePath = "\(id)"
        case .deleteIssueType(let id, let params):
            method = .delete
            relativePath = "\(id)"
            parameters = params
        case .updateIssueType(let id):
            method = .put
            relativePath = "\(id)"
        case .getAlternativeIssueTypes(let id):
            method = .get
            relativePath = "\(id)/alternatives"
        case .createAvatar(let id, let params):
            method = .post
            relativePath = "\(id)/avatar2"
            parameters = params
        }
        
        let url: URL = {
            var url = URL(string: "\(jiraBaseURL)/rest/api/2/issuetype")!
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
