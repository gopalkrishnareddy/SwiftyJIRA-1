import Foundation
import Alamofire

struct ProjectsCardsRouter: URLRequestConvertible {
    
    enum Action {
        case projectCards(columnId: Int)
        case projectCard(id: Int)
        case createProjectCard(columnId: Int, params: Parameters)
        case updateProjectCard(id: Int, params: Parameters)
        case deleteProjectCard(id: Int)
        case moveProjectCard(id: Int, params: Parameters)
    }
    
    let user: String
    let password: String
    let action: Action
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self.action {
            case .projectCards:
                return .get
            case .projectCard:
                return .get
            case .createProjectCard:
                return .post
            case .updateProjectCard:
                return .patch
            case .deleteProjectCard:
                return .delete
            case .moveProjectCard:
                return .post
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .createProjectCard(_, let params):
                return params
            case .updateProjectCard(_, let params):
                return params
            case .moveProjectCard(_, let params):
                return params
            default:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .projectCards(let columnId):
                relativePath = "projects/columns/\(columnId)/cards"
            case .projectCard(let id):
                relativePath = "projects/columns/cards/\(id)"
            case .createProjectCard(let columnId, _):
                relativePath = "projects/columns/\(columnId)/cards"
            case .updateProjectCard(let id, _):
                relativePath = "projects/columns/cards/\(id)"
            case .deleteProjectCard(let id):
                relativePath = "projects/columns/cards/\(id)"
            case .moveProjectCard(let id, _):
                relativePath = "projects/columns/cards/\(id)/moves"
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

