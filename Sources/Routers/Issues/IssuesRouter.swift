import Foundation
import Alamofire

struct IssuesRouter: URLRequestConvertible {
    
    enum Action {
        case repoIssues(params: Parameters)
        case issue(number: Int)
        case createIssue(params: Parameters)
        case editIssue(number: Int, params: Parameters)
        case lockIssue(number: Int)
        case unlockIssue(number: Int)
    }
    
    let user: String
    let password: String
    let owner: String
    let repo: String
    let action: Action
    
    var baseURLString: String {
        return "\(base)/repos/\(owner)/\(repo)"
    }
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self.action {
            case .repoIssues:
                return .get
            case .issue:
                return .get
            case .createIssue:
                return .post
            case .editIssue:
                return .patch
            case .lockIssue:
                return .put
            case .unlockIssue:
                return .delete
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .repoIssues(let params):
                return params
            case .createIssue(let params):
                return params
            case .editIssue(_, let params):
                return params
            default:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .repoIssues:
                relativePath = "repos/\(owner)/\(repo)/issues"
            case .issue(let number):
                relativePath = "repos/\(owner)/\(repo)/issues/\(number)"
            case .createIssue:
                relativePath = "repos/\(owner)/\(repo)/issues"
            case .editIssue(let number, _):
                relativePath = "repos/\(owner)/\(repo)/issues/\(number)"
            case .lockIssue(let number):
                relativePath = "repos/\(owner)/\(repo)/issues/\(number)/lock"
            case .unlockIssue(let number):
                relativePath = "repos/\(owner)/\(repo)/issues/\(number)/lock"
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
        
        if case .lockIssue = self.action {
            urlRequest.setValue("0", forHTTPHeaderField: "Content-Length")
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
