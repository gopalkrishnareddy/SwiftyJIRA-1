import Foundation
import Alamofire

struct IssuesAssigneesRouter: URLRequestConvertible {
    
    enum Action {
        case availableAssignees
        case checkAssignee(assignee: String)
        case addAssignees(number: Int, params: Parameters)
        case removeAssignees(number: Int, params: Parameters)
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
            case .availableAssignees:
                return .get
            case .checkAssignee:
                return .get
            case .addAssignees:
                return .post
            case .removeAssignees:
                return .delete
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .addAssignees(_, let params):
                return params
            case .removeAssignees(_, let params):
                return params
            default:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .availableAssignees:
                relativePath = "assignees"
            case .checkAssignee(let assignee):
                relativePath = "assignees/\(assignee)"
            case .addAssignees(let number, _):
                relativePath = "issues/\(number)/assignees"
            case .removeAssignees(let number, _):
                relativePath = "issues/\(number)/assignees"
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
