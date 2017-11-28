//
//  JIRAIssuesRouter.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

struct JIRAIssuesRouter: URLRequestConvertible {
    
    enum Action {
        case createIssue(body: JIRACreateIssueBody, params: Parameters)
        case createIssues(body: JIRACreateIssuesBody)
        case getIssue(issueIdOrKey: String, params: Parameters)
        case deleteIssue(issueIdOrKey: String, params: Parameters)
        case editIssue(issueIdOrKey: String, params: Parameters)
        case assign(issueIdOrKey: String, params: Parameters)
        case getEditIssueMetadata(issueIdOrKey: String, params: Parameters)
        case notify(issueIdOrKey: String, params: Parameters)
        case createUpdateRemoteIssueLink(issueIdOrKey: String, params: Parameters)
        case deleteRemoteIssueLinkByGlobalId(issueIdOrKey: String, params: Parameters)
        case getRemoteIssueLinks(issueIdOrKey: String, params: Parameters)
        case getRemoteIssueLinkById(issueIdOrKey: String, linkId: String, params: Parameters)
        case updateRemoteIssueLink(issueIdOrKey: String, linkId: String, params: Parameters)
        case deleteRemoteIssueLinkById(issueIdOrKey: String, linkId: String, params: Parameters)
        case doTransition(issueIdOrKey: String, params: Parameters)
        case getTransitions(issueIdOrKey: String, params: Parameters)
        case removeVote(issueIdOrKey: String, params: Parameters)
        case addVote(issueIdOrKey: String, params: Parameters)
        case getVotes(issueIdOrKey: String, params: Parameters)
        case getIssueWatchers(issueIdOrKey: String, params: Parameters)
        case addWatcher(issueIdOrKey: String, params: Parameters)
        case removeWatcher(issueIdOrKey: String, params: Parameters)
        case getCreateIssueMetadata(params: Parameters)
        case getIssuePickerResource(params: Parameters)
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
        case .createIssue(let body, let params):
            method = .post
            parameters = params
            bodyData = try JSONEncoder().encode(body)
        case .createIssues(let body):
            method = .post
            relativePath = "bulk"
            bodyData = try JSONEncoder().encode(body)
        case .getIssue(let issueIdOrKey, let params):
            method = .get
            relativePath = "\(issueIdOrKey)"
            parameters = params
        case .deleteIssue(let issueIdOrKey, let params):
            method = .delete
            relativePath = "\(issueIdOrKey)"
            parameters = params
        case .editIssue(let issueIdOrKey, let params):
            method = .put
            relativePath = "\(issueIdOrKey)"
            parameters = params
        case .assign(let issueIdOrKey, let params):
            method = .put
            relativePath = "\(issueIdOrKey)/assignee"
            parameters = params
        case .getEditIssueMetadata(let issueIdOrKey, let params):
            method = .get
            relativePath = "\(issueIdOrKey)/editmeta"
            parameters = params
        case .notify(let issueIdOrKey, let params):
            method = .post
            relativePath = "\(issueIdOrKey)/notify"
            parameters = params
        case .createUpdateRemoteIssueLink(let issueIdOrKey, let params):
            method = .post
            relativePath = "\(issueIdOrKey)/remotelink"
            parameters = params
        case .deleteRemoteIssueLinkByGlobalId(let issueIdOrKey, let params):
            method = .delete
            relativePath = "\(issueIdOrKey)/remotelink"
            parameters = params
        case .getRemoteIssueLinks(let issueIdOrKey, let params):
            method = .get
            relativePath = "\(issueIdOrKey)/remotelink"
            parameters = params
        case .getRemoteIssueLinkById(let issueIdOrKey, let linkId, let params):
            method = .get
            relativePath = "\(issueIdOrKey)/remotelink/\(linkId)"
            parameters = params
        case .updateRemoteIssueLink(let issueIdOrKey, let linkId, let params):
            method = .put
            relativePath = "\(issueIdOrKey)/remotelink/\(linkId)"
            parameters = params
        case .deleteRemoteIssueLinkById(let issueIdOrKey, let linkId, let params):
            method = .delete
            relativePath = "\(issueIdOrKey)/remotelink/\(linkId)"
            parameters = params
        case .doTransition(let issueIdOrKey, let params):
            method = .post
            relativePath = "\(issueIdOrKey)/transitions"
            parameters = params
        case .getTransitions(let issueIdOrKey, let params):
            method = .get
            relativePath = "\(issueIdOrKey)/transitions"
            parameters = params
        case .removeVote(let issueIdOrKey, let params):
            method = .delete
            relativePath = "\(issueIdOrKey)/votes"
            parameters = params
        case .addVote(let issueIdOrKey, let params):
            method = .post
            relativePath = "\(issueIdOrKey)/votes"
            parameters = params
        case .getVotes(let issueIdOrKey, let params):
            method = .get
            relativePath = "\(issueIdOrKey)/votes"
            parameters = params
        case .getIssueWatchers(let issueIdOrKey, let params):
            method = .get
            relativePath = "\(issueIdOrKey)/watchers"
            parameters = params
        case .addWatcher(let issueIdOrKey, let params):
            method = .post
            relativePath = "\(issueIdOrKey)/watchers"
            parameters = params
        case .removeWatcher(let issueIdOrKey, let params):
            method = .delete
            relativePath = "\(issueIdOrKey)/watchers"
            parameters = params
        case .getCreateIssueMetadata(let params):
            method = .get
            relativePath = "createmeta"
            parameters = params
        case .getIssuePickerResource(let params):
            method = .get
            relativePath = "picker"
            parameters = params
        }
        
        let url: URL = {
            var url = URL(string: "\(jiraBaseURL)/rest/api/2/issue")!
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
