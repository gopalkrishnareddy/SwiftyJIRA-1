//
//  JIRAStatusesController.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Dispatch
import Alamofire

/// The controller class for the JIRA Projects REST API
public class JIRAStatusesController {
    
    /// JIRA user
    let user: String
    /// JIRA password
    let password: String
    
    private let queue = DispatchQueue(label: "com.polka.cat.SwiftyJIRA")
    
    /// Create instance of `JIRAWorkflowsController`
    ///
    /// - Parameters:
    ///   - user: JIRA user
    ///   - password: JIRA password
    public init(user: String, password: String) {
        self.user = user
        self.password = password
    }
    
    public func getStatuses(
        completion: @escaping ([JIRAIssueStatus]?) -> Void)
    {
        let request = JIRAStatusesRouter(user: user,
                                         password: password,
                                         action: .getStatuses)
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([JIRAIssueStatus].self, from: data))
        }
    }
    
    public func getStatus(
        idOrName: String,
        completion: @escaping (JIRAIssueStatus?) -> Void)
    {
        let request = JIRAStatusesRouter(user: user,
                                         password: password,
                                         action: .getStatus(idOrName: idOrName))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(JIRAIssueStatus.self, from: data))
        }
    }
}
