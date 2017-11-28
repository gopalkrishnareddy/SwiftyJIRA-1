//
//  JIRAWorkflowsController.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Dispatch
import Alamofire

/// The controller class for the JIRA Workflows REST API
public class JIRAWorkflowsController {
    
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
    
    public func getAllWorkflows(
        completion: @escaping ([JIRAWorkflow]?) -> Void)
    {
        let request = JIRAWorkflowsRouter(user: user,
                                         password: password,
                                         action: .getAllWorkflows(params: nil))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([JIRAWorkflow].self, from: data))
        }
    }
    
    public func getWorkflow(
        workflowName: String,
        completion: @escaping (JIRAWorkflow?) -> Void)
    {
        let parameters: Parameters = ["workflowName": workflowName]
        let request = JIRAWorkflowsRouter(user: user,
                                          password: password,
                                          action: .getAllWorkflows(params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(JIRAWorkflow.self, from: data))
        }
    }
    
    public func deleteProperty() {
        // TODO: Implement
    }
    
    public func createProperty() {
        // TODO: Implement
    }
    
    public func updateProperty() {
        // TODO: Implement
    }
    
    public func getProperties() {
        // TODO: Implement
    }
}
