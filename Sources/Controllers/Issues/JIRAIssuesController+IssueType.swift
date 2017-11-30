//
//  JIRAIssuesController+IssueType.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

extension JIRAIssuesController {
    
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
                completion(try? JSONDecoder().decode([JIRAIssueType].self, from: data))
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
                completion(try? JSONDecoder().decode(JIRAIssueType.self, from: data))
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
