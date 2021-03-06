//
//  JIRAIssueTypesController.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

/// The controller class for the JIRA issue types REST API
public class JIRAIssueTypesController {
    
    /// JIRA user
    let user: String
    /// JIRA password
    let password: String
    
    /// Create instance of `JIRAIssuesController`
    ///
    /// - Parameters:
    ///   - user: JIRA user
    ///   - password: JIRA password
    public init(user: String, password: String) {
        self.user = user
        self.password = password
    }
    
    /// Returns a list of all issue types visible to the user
    public func getAllIssueTypes(
        completion: @escaping ([JIRAIssueType]?) -> Void)
    {
        let request = JIRAIssueTypeRouter(user: user,
                                          password: password,
                                          action: .getAllIssueTypes)
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode([JIRAIssueType].self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func createIssueType() {
        // TODO: Implement
    }
    
    public func getIssueType(
        id: String,
        completion: @escaping (JIRAIssueType?) -> Void)
    {
        let request = JIRAIssueTypeRouter(user: user,
                                          password: password,
                                          action: .getIssueType(id: id))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode(JIRAIssueType.self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func deleteIssueType() {
        // TODO: Implement
    }
    
    public func updateIssueType() {
        // TODO: Implement
    }
    
    public func getAlternativeIssueTypes() {
        // TODO: Implement
    }
    
    public func createAvatar() {
        // TODO: Implement
    }
}
