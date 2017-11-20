import Foundation
import Alamofire

struct ProjectsRouter: URLRequestConvertible {
    
    enum Action {
        case repositoryProjects(params: Parameters)
        case organizationProjects(org: String, params: Parameters)
        case project(id: Int)
        case createRepositoryProject(params: Parameters)
        case createOrganizationProject(org: String, params: Parameters)
        case updateProject(id: Int, params: Parameters)
        case deleteProject(id: Int)
    }
    
    let user: String
    let password: String
    let owner: String
    let repo: String
    let action: Action
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self.action {
            case .repositoryProjects:
                return .get
            case .organizationProjects:
                return .get
            case .project:
                return .get
            case .createRepositoryProject:
                return .post
            case .createOrganizationProject:
                return .post
            case .updateProject:
                return .patch
            case .deleteProject:
                return .delete
            }
        }
        
        let params: (Parameters?) = {
            switch self.action {
            case .repositoryProjects(let params):
                return params
            case .organizationProjects(_, let params):
                return params
            case .createRepositoryProject(let params):
                return params
            case .createOrganizationProject(_, let params):
                return params
            case .updateProject(_, let params):
                return params
            default:
                return nil
            }
        }()
        
        let url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self.action {
            case .repositoryProjects:
                relativePath = "repos/\(owner)/\(repo)/projects"
            case .organizationProjects(let org, _):
                relativePath = "orgs/\(org)/projects"
            case .project(let id):
                relativePath = "projects/\(id)"
            case .createRepositoryProject:
                relativePath = "repos/\(owner)/\(repo)/projects"
            case .createOrganizationProject(let org, _):
                relativePath = "orgs/\(org)/projects"
            case .updateProject(let id, _):
                relativePath = "projects/\(id)"
            case .deleteProject(let id):
                relativePath = "projects/\(id)"
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
