//
//  JIRAIssuesRouter.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

struct JIRAIssuesCommentsRouter: URLRequestConvertible {
    
    enum Action {
        case addComment(issueIdOrKey: String, body: JIRACommentJSONBean, params: Parameters)
        case getComments(issueIdOrKey: String, params: Parameters)
        case updateComment(issueIdOrKey: String, id: String, body: JIRACommentJSONBean, params: Parameters)
        case deleteComment(issueIdOrKey: String, id: String)
        case getComment(issueIdOrKey: String, id: String, params: Parameters)
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
        case .addComment(let issueIdOrKey, let body, let params):
            method = .post
            parameters = params
            relativePath = "\(issueIdOrKey)/comment"
            bodyData = try JSONEncoder().encode(body)
        case .getComments(let issueIdOrKey, let params):
            method = .get
            parameters = params
            relativePath = "\(issueIdOrKey)/comment"
        case .updateComment(let issueIdOrKey, let id, let body, let params):
            method = .put
            parameters = params
            relativePath = "\(issueIdOrKey)/comment/\(id)"
            bodyData = try JSONEncoder().encode(body)
        case .deleteComment(let issueIdOrKey, let id):
            method = .delete
            relativePath = "\(issueIdOrKey)/comment/\(id)"
        case .getComment(let issueIdOrKey, let id, let params):
            method = .get
            parameters = params
            relativePath = "\(issueIdOrKey)/comment/\(id)"
        }
        
        let url: URL = {
            var url = URL(string: "\(jiraBaseURL)/issue")!
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
