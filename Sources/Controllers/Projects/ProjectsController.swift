import Foundation
import Alamofire

public class ProjectsController {
    
    let user: String
    let password: String
    public var owner: String
    public var repo: String
    public var org: String?
    
    public init(user: String, password: String, owner: String, repo: String, org: String? = nil) {
        self.user = user
        self.password = password
        self.owner = owner
        self.repo = repo
        self.org = org
    }
    
    public func listRepositoryProjects(
        state: ProjectState = .open,
        completion: @escaping ([Project]?) -> Void)
    {
        let parameters: Parameters = ["state": state.rawValue]
        let request = ProjectsRouter(user: user,
                                     password: password,
                                     owner: owner,
                                     repo: repo,
                                     action: .repositoryProjects(params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(try? JSONDecoder().decode([Project].self, from: data))
        }
    }

    public func listOrganizationProjects(
        org: String,
        state: ProjectState = .open,
        completion: @escaping ([Project]?) -> Void)
    {
        let parameters: Parameters = ["state": state.rawValue]
        let request = ProjectsRouter(user: user,
                                     password: password,
                                     owner: owner,
                                     repo: repo,
                                     action: .organizationProjects(org: org, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(try? JSONDecoder().decode([Project].self, from: data))
        }
    }
    
    public func getProject(
        id: Int,
        completion: @escaping (Project?) -> Void)
    {
        let request = ProjectsRouter(user: user,
                                     password: password,
                                     owner: owner,
                                     repo: repo,
                                     action: .project(id: id))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(Project.self, from: data))
        }
    }

    public func createRepositoryProject(
        name: String,
        body: String? = nil,
        completion: @escaping (Project?) -> Void)
    {
        var parameters: Parameters = ["name": name]
        if let body = body {
            parameters["body"] = body
        }
        let request = ProjectsRouter(user: user,
                                     password: password,
                                     owner: owner,
                                     repo: repo,
                                     action: .createRepositoryProject(params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(try? JSONDecoder().decode(Project.self, from: data))
        }
    }

    public func createOrganizationProject(
        org: String,
        name: String,
        body: String? = nil,
        completion: @escaping (Project?) -> Void)
    {
        var parameters: Parameters = ["name": name]
        if let body = body {
            parameters["body"] = body
        }
        let request = ProjectsRouter(user: user,
                                     password: password,
                                     owner: owner,
                                     repo: repo,
                                     action: .createOrganizationProject(org: org, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(try? JSONDecoder().decode(Project.self, from: data))
        }
    }

    public func updateProject(
        id: Int,
        name: String? = nil,
        body: String? = nil,
        state: UpdateProjectState? = nil,
        completion: @escaping (Project?) -> Void)
    {
        var parameters: Parameters = [:]
        if let name = name {
            parameters["name"] = name
        }
        if let body = body {
            parameters["body"] = body
        }
        if let state = state {
            parameters["state"] = state.rawValue
        }
        let request = ProjectsRouter(user: user,
                                     password: password,
                                     owner: owner,
                                     repo: repo,
                                     action: .updateProject(id: id, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(Project.self, from: data))
        }
    }

    public func deleteProject(
        id: Int,
        completion: @escaping (Bool) -> Void)
    {
        let request = ProjectsRouter(user: user,
                                     password: password,
                                     owner: owner,
                                     repo: repo,
                                     action: .deleteProject(id: id))
        Alamofire.request(request)
            .validate(statusCode: 204..<205)
            .responseJSON { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    public enum ProjectState: String {
        case open
        case closed
        case all
    }
    
    public enum UpdateProjectState: String {
        case open
        case closed
    }
}
