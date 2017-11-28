//
//  JIRAProjectsRouter.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

struct JIRAProjectsRouter: URLRequestConvertible {
    
    enum Action {
        case getAllProjects(params: Parameters)
        case getProject(projectIdOrKey: String, params: Parameters)
        case getAllStatuses(projectIdOrKey: String)
        case getProjectVersionsPaginated(projectIdOrKey: String, params: Parameters)
        case getProjectVersions(projectIdOrKey: String, params: Parameters)
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
        case .getAllProjects(let params):
            method = .get
            parameters = params
        case .getProject(let projectIdOrKey, let params):
            method = .get
            relativePath = "\(projectIdOrKey)"
            parameters = params
        case .getAllStatuses(let projectIdOrKey):
            method = .get
            relativePath = "\(projectIdOrKey)/statuses"
        case .getProjectVersionsPaginated(let projectIdOrKey, let params):
            method = .get
            relativePath = "\(projectIdOrKey)/version"
            parameters = params
        case .getProjectVersions(let projectIdOrKey, let params):
            method = .get
            relativePath = "\(projectIdOrKey)/versions"
            parameters = params
        }
        
        let url: URL = {
            var url = URL(string: "\(jiraBaseURL)/rest/api/2/project")!
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

