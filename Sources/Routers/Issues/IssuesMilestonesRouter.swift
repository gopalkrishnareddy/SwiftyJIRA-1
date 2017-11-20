import Foundation
import Alamofire

struct IssuesMilestonesRouter: URLRequestConvertible {
    
    enum Action {
        case repositoryMilestones(params: Parameters)
        case milestone(number: Int)
        case createMilestone(params: Parameters)
        case updateMilestone(number: Int, params: Parameters)
        case deleteMilestone(number: Int)
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
            case .repositoryMilestones:
                return .get
            case .milestone:
                return .get
            case .createMilestone:
                return .post
            case .updateMilestone:
                return .patch
            case .deleteMilestone:
                return .delete
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .repositoryMilestones(let params):
                return params
            case .createMilestone(let params):
                return params
            case .updateMilestone(_, let params):
                return params
            default:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .repositoryMilestones:
                relativePath = "milestones"
            case .milestone(let number):
                relativePath = "milestones/\(number)"
            case .createMilestone:
                relativePath = "milestones"
            case .updateMilestone(let number, _):
                relativePath = "milestones/\(number)"
            case .deleteMilestone(let number):
                relativePath = "milestones/\(number)"
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
