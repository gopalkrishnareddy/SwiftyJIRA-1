import Foundation
import Alamofire

struct IssuesLabelsRouter: URLRequestConvertible {
    
    enum Action {
        case allLabels
        case label(name: String)
        case createLabel(params: Parameters)
        case updateLabel(name: String, params: Parameters)
        case deleteLabel(name: String)
        case issueLabels(number: Int)
        case addLabels(number: Int, params: Parameters)
        case removeLabel(number: Int, name: String)
        case replaceLabels(number: Int, params: Parameters)
        case removeAllLabels(number: Int)
        case milestoneLabels(number: Int)
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
            case .allLabels:
                return .get
            case .label:
                return .get
            case .createLabel:
                return .post
            case .updateLabel:
                return .patch
            case .deleteLabel:
                return .delete
            case .issueLabels:
                return .get
            case .addLabels:
                return .post
            case .removeLabel:
                return .delete
            case .replaceLabels:
                return .put
            case .removeAllLabels:
                return .delete
            case .milestoneLabels:
                return .get
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .createLabel(let params):
                return params
            case .updateLabel(_, let params):
                return params
            case .addLabels(_, let params):
                return params
            case .replaceLabels(_, let params):
                return params
            default:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .allLabels:
                relativePath = "labels"
            case .label(let name):
                relativePath = "labels/\(name)"
            case .createLabel:
                relativePath = "labels"
            case .updateLabel(let name, _):
                relativePath = "labels/\(name)"
            case .deleteLabel(let name):
                relativePath = "labels/\(name)"
            case .issueLabels(let number):
                relativePath = "issues/\(number)/labels"
            case .addLabels(let number, _):
                relativePath = "issues/\(number)/labels"
            case .removeLabel(let number, let name):
                relativePath = "issues/\(number)/labels/\(name)"
            case .replaceLabels(let number, _):
                relativePath = "issues/\(number)/labels"
            case .removeAllLabels(let number):
                relativePath = "issues/\(number)/labels"
            case .milestoneLabels(let number):
                relativePath = "milestones/\(number)/labels"
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
            switch self.action {
            case .addLabels, .replaceLabels:
                return ArrayEncoding()
            default:
                break
            }
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
