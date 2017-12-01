//
//  JIRAProjectsController.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

/// The controller class for the JIRA Projects REST API
public class JIRAProjectsController {
    
    /// JIRA user
    let user: String
    /// JIRA password
    let password: String
    
    /// Create instance of `JIRAWorkflowsController`
    ///
    /// - Parameters:
    ///   - user: JIRA user
    ///   - password: JIRA password
    public init(user: String, password: String) {
        self.user = user
        self.password = password
    }
    
    public func createProject() {
        // TODO: Implement
    }
    
    /// Returns all projects visible for the currently logged in user, ie. all the projects the user has either 'Browse projects' or 'Administer projects' permission. If no user is logged in, it returns all projects that are visible for anonymous users.
    ///
    /// - Parameters:
    ///   - expand: Multi-value parameter defining request properties to expand in the response. These are not returned by default.
    ///   - recent: Only projects recently accessed by the current user will be returned if this parameter is set. If no user is logged in, recently accessed projects will be returned based on current HTTP session. Maximum count is limited to the specified number, but no more than 20.
    ///   - completion: Completion handler
    public func getAllProjects(
        expand: [JIRAProjectsExpandParameter]? = nil,
        recent: Int? = nil,
        completion: @escaping ([JIRAProject]?) -> Void)
    {
        var parameters: Parameters = [:]
        if let expand = expand {
            parameters["expand"] = expand
        }
        if let recent = recent {
            parameters["recent"] = recent
        }
        let request = JIRAProjectsRouter(user: user,
                                         password: password,
                                         action: .getAllProjects(params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode([JIRAProject].self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func updateProject() {
        // TODO: Implement
    }
    
    public func deleteProject() {
        // TODO: Implement
    }
    
    /// Returns a full representation of a single project.
    ///
    /// - Parameters:
    ///   - projectIdOrKey: Project id or key
    ///   - expand: Multi-value parameter defining request properties to expand in the response. These are not returned by default.
    ///   - completion: Completion handler
    public func getProject(
        projectIdOrKey: String,
        expand: [JIRAProjectExpandParameter]? = nil,
        completion: @escaping (JIRAProject?) -> Void)
    {
        var parameters: Parameters = [:]
        if let expand = expand {
            parameters["expand"] = expand
        }
        let request = JIRAProjectsRouter(user: user,
                                         password: password,
                                         action: .getProject(projectIdOrKey: projectIdOrKey, params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode(JIRAProject.self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func updateProjectAvatar() {
        // TODO: Implement
    }
    
    public func deleteAvatar() {
        // TODO: Implement
    }
    
    public func createAvatar() {
        // TODO: Implement
    }
    
    public func getAllAvatars() {
        // TODO: Implement
    }
    
    public func getProjectComponents(paginated: Bool = false) {
        // TODO: Implement
    }
    
    public func getAllStatuses() {
        // TODO: Implement
    }
    
    public func updateProjectType() {
        // TODO: Implement
    }
    
    public func getProjectVersionsPaginated() {
        // TODO: Implement
    }
    
    public func getProjectVersions(
        projectIdOrKey: String,
        expand: String? = nil,
        completion: @escaping ([JIRAVersion]?) -> Void)
    {
        var parameters: Parameters = [:]
        if let expand = expand {
            parameters["expand"] = expand
        }
        let request = JIRAProjectsRouter(user: user,
                                         password: password,
                                         action: .getProjectVersions(projectIdOrKey: projectIdOrKey, params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode([JIRAVersion].self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
}

/// Multi-value parameter defining request properties to expand in the response. These are not returned by default.
public enum JIRAProjectsExpandParameter: String, Codable {
    /// Description of the project.
    case description
    /// All project keys associated with the project.
    case projectKeys
    /// Project lead. Note, that project lead role is different from project administrator one.
    case lead
    /// Issue types associated with the project.
    case issueTypes
    /// A URL associated with the project.
    case url
}

/// Multi-value parameter defining request properties to expand in the response. These are not returned by default.
public enum JIRAProjectExpandParameter: String, Codable {
    /// Description of the project.
    case description
    /// All project keys associated with the project.
    case projectKeys
    /// Project lead. Note that the project lead does not always have 'administer projects' permission, and multiple users can have 'administer projects' permission for a given project.
    case lead
    /// Issue types associated with the project.
    case issueTypes
}
