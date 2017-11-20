import Foundation
import Alamofire

struct IssuesCommentsRouter: URLRequestConvertible {
    
    enum Action {
        case issueComments(number: Int, params: Parameters)
        case repositoryComments(params: Parameters)
        case comment(id: Int)
        case createComment(number: Int, params: Parameters)
        case editComment(id: Int, params: Parameters)
        case deleteComment(id: Int)
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
            case .issueComments:
                return .get
            case .repositoryComments:
                return .get
            case .comment:
                return .get
            case .createComment:
                return .post
            case .editComment:
                return .patch
            case .deleteComment:
                return .delete
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .issueComments(_, let params):
                return params
            case .repositoryComments(let params):
                return params
            case .createComment(_, let params):
                return params
            case .editComment(_, let params):
                return params
            default:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .issueComments(let number, _):
                relativePath = "issues/\(number)/comments"
            case .repositoryComments:
                relativePath = "issues/comments"
            case .comment(let id):
                relativePath = "issues/comments/\(id)"
            case .createComment(let number, _):
                relativePath = "issues/\(number)/comments"
            case .editComment(let id, _):
                relativePath = "issues/comments/\(id)"
            case .deleteComment(let id):
                relativePath = "issues/comments/\(id)"
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
