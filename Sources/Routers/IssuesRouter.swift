import Foundation
import Alamofire

struct IssuesRouter: URLRequestConvertible {
    
    enum Action {
        case createIssue(params: Parameters)
        case createIssues(params: Parameters)
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
    let owner: String
    let repo: String
    let action: Action
    
    var baseURLString: String {
        return "\(base)/repos/\(owner)/\(repo)/issue"
    }
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self.action {
            case .createIssue:
                return .post
            case .createIssues:
                return .post
            case .getIssue:
                return .get
            case .deleteIssue:
                return .delete
            case .editIssue:
                return .put
            case .assign:
                return .put
            case .getEditIssueMetadata:
                return .get
            case .notify:
                return .post
            case .createUpdateRemoteIssueLink:
                return .post
            case .deleteRemoteIssueLinkByGlobalId:
                return .delete
            case .getRemoteIssueLinks:
                return .delete
            case .getRemoteIssueLinkById:
                return .delete
            case .updateRemoteIssueLink:
                return .put
            case .deleteRemoteIssueLinkById:
                return .delete
            case .doTransition:
                return .post
            case .getTransitions:
                return .get
            case .removeVote:
                return .delete
            case .addVote:
                return .post
            case .getVotes:
                return .get
            case .getIssueWatchers:
                return .get
            case .addWatcher:
                return .post
            case .removeWatcher:
                return .delete
            case .getCreateIssueMetadata:
                return .get
            case .getIssuePickerResource:
                return .get
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .createIssue(let params):
                return params
            case .createIssues(let params):
                return params
            case .getIssue(_, let params):
                return params
            case .deleteIssue(_, let params):
                return params
            case .editIssue(_, let params):
                return params
            case .assign(_, let params):
                return params
            case .getEditIssueMetadata(_, let params):
                return params
            case .notify(_, let params):
                return params
            case .createUpdateRemoteIssueLink(_, let params):
                return params
            case .deleteRemoteIssueLinkByGlobalId(_, let params):
                return params
            case .getRemoteIssueLinks(_, let params):
                return params
            case .getRemoteIssueLinkById(_, _, let params):
                return params
            case .updateRemoteIssueLink(_, _, let params):
                return params
            case .deleteRemoteIssueLinkById(_, _, let params):
                return params
            case .doTransition(_, let params):
                return params
            case .getTransitions(_, let params):
                return params
            case .removeVote(_, let params):
                return params
            case .addVote(_, let params):
                return params
            case .getVotes(_, let params):
                return params
            case .getIssueWatchers(_, let params):
                return params
            case .addWatcher(_, let params):
                return params
            case .removeWatcher(_, let params):
                return params
            case .getCreateIssueMetadata(let params):
                return params
            case .getIssuePickerResource(let params):
                return params
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .createIssue:
                relativePath = ""
            case .createIssues:
                relativePath = "bulk"
            case .getIssue(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)"
            case .deleteIssue(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)"
            case .editIssue(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)"
            case .assign(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/assignee"
            case .getEditIssueMetadata(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/editmeta"
            case .notify(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/notify"
            case .createUpdateRemoteIssueLink(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/remotelink"
            case .deleteRemoteIssueLinkByGlobalId(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/remotelink"
            case .getRemoteIssueLinks(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/remotelink"
            case .getRemoteIssueLinkById(let issueIdOrKey, let linkId, _):
                relativePath = "\(issueIdOrKey)/remotelink/\(linkId)"
            case .updateRemoteIssueLink(let issueIdOrKey, let linkId, _):
                relativePath = "\(issueIdOrKey)/remotelink/\(linkId)"
            case .deleteRemoteIssueLinkById(let issueIdOrKey, let linkId, _):
                relativePath = "\(issueIdOrKey)/remotelink/\(linkId)"
            case .doTransition(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/transitions"
            case .getTransitions(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/transitions"
            case .removeVote(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/votes"
            case .addVote(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/votes"
            case .getVotes(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/votes"
            case .getIssueWatchers(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/watchers"
            case .addWatcher(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/watchers"
            case .removeWatcher(let issueIdOrKey, _):
                relativePath = "\(issueIdOrKey)/watchers"
            case .getCreateIssueMetadata:
                relativePath = "createmeta"
            case .getIssuePickerResource:
                relativePath = "picker"
            }
            
            
            var url = URL(string: baseURLString)!
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
        return try encoding.encode(urlRequest, with: params)
    }
}
