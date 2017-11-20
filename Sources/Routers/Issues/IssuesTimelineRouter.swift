import Foundation
import Alamofire

struct IssuesTimelineRouter: URLRequestConvertible {
    
    enum Action {
        case issueEvents(number: Int)
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
            case .issueEvents:
                return .get
            }
        }
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .issueEvents(let number):
                relativePath = "issues/\(number)/timeline"
            }
            
            var url = URL(string: baseURLString)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/vnd.github.mockingbird-preview", forHTTPHeaderField: "Accept")
        
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
        return try encoding.encode(urlRequest, with: nil)
    }
}

