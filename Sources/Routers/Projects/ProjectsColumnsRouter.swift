import Foundation
import Alamofire

struct ProjectsColumnsRouter: URLRequestConvertible {
    
    enum Action {
        case projectColumns(projectId: Int)
        case projectColumn(id: Int)
        case createProjectColumn(projectId: Int, params: Parameters)
        case updateProjectColumn(id: Int, params: Parameters)
        case deleteProjectColumn(id: Int)
        case moveProjectColumn(id: Int, params: Parameters)
    }
    
    let user: String
    let password: String
    let action: Action
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self.action {
            case .projectColumns:
                return .get
            case .projectColumn:
                return .get
            case .createProjectColumn:
                return .post
            case .updateProjectColumn:
                return .patch
            case .deleteProjectColumn:
                return .delete
            case .moveProjectColumn:
                return .post
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .createProjectColumn(_, let params):
                return params
            case .updateProjectColumn(_, let params):
                return params
            case .moveProjectColumn(_, let params):
                return params
            default:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .projectColumns(let projectId):
                relativePath = "projects/\(projectId)/columns"
            case .projectColumn(let id):
                relativePath = "projects/columns/\(id)"
            case .createProjectColumn(let projectId, _):
                relativePath = "projects/\(projectId)/columns"
            case .updateProjectColumn(let id, _):
                relativePath = "projects/columns/\(id)"
            case .deleteProjectColumn(let id):
                relativePath = "projects/columns/\(id)"
            case .moveProjectColumn(let id, _):
                relativePath = "projects/columns/\(id)/moves"
            }
            
            var url = URL(string: base)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/vnd.github.inertia-preview+json", forHTTPHeaderField: "Accept")
        
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

