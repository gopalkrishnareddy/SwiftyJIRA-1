import Foundation
import Alamofire

struct OrganizationRouter: URLRequestConvertible {
    
    enum Action {
        case orgIssues(org: String, params: Parameters)
    }
    
    let user: String
    let password: String
    let org: String
    let action: Action
    
    var baseURLString: String {
        return "\(base)/org/\(org)"
    }
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self.action {
            case .orgIssues:
                return .get
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .orgIssues(_, let params):
                return params
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .orgIssues(let org, _):
                relativePath = "org/\(org)/issues"
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

