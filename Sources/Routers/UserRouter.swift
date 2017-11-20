import Foundation
import Alamofire

struct UserRouter: URLRequestConvertible {
    
    enum Action {
        case userIssues(params: Parameters)
    }
    
    let user: String
    let password: String
    let action: Action
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self.action {
            case .userIssues:
                return .get
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .userIssues(let params):
                return params
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .userIssues:
                relativePath = "user/issues"
            }
            
            
            var url = URL(string: base)!
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
