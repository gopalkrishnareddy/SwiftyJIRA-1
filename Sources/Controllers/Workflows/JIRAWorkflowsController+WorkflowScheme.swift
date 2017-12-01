//
//  JIRAWorkflowsController+WorkflowScheme.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

extension JIRAWorkflowsController {
    
    public func createScheme() {
        // TODO: Implement
    }
    
    public func getByID(
        id: Int,
        returnDraftIfExists: Bool = false,
        completion: @escaping (JIRAWorkflowScheme?) -> Void)
    {
        let parameters: Parameters = ["returnDraftIfExists": returnDraftIfExists]
        let request = JIRAWorkflowSchemesRouter(user: user,
                                                password: password,
                                                action: .getById(id: id, params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode(JIRAWorkflowScheme.self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func deleteScheme() {
        // TODO: Implement
    }
    
    public func update() {
        // TODO: Implement
    }
    
    public func createDraftForParent() {
        // TODO: Implement
    }
    
    public func deleteDefault() {
        // TODO: Implement
    }
    
    public func updateDefault() {
        // TODO: Implement
    }
    
    public func getDefault() {
        // TODO: Implement
    }
    
    public func getDraftByID() {
        // TODO: Implement
    }
    
    public func deleteDraftByID() {
        // TODO: Implement
    }
    
    public func updateDraft() {
        // TODO: Implement
    }
    
    public func getDraftDefault() {
        // TODO: Implement
    }
    
    public func deleteDraftDefault() {
        // TODO: Implement
    }
    
    public func updateDraftDefault() {
        // TODO: Implement
    }
    
    public func getDraftIssueType() {
        // TODO: Implement
    }
    
    public func setDraftIssueType() {
        // TODO: Implement
    }
    
    public func getDraftWorkflow() {
        // TODO: Implement
    }
    
    public func deleteDraftWorkflowMapping() {
        // TODO: Implement
    }
    
    public func updateDraftWorkflowMapping() {
        // TODO: Implement
    }
    
    /// Returns the issue type mapping for the passed workflow scheme.
    public func getIssueType(
        id: Int,
        issueType: String,
        returnDraftIfExists: Bool = false,
        completion: @escaping (JIRAIssueType?) -> Void)
    {
        let parameters: Parameters = ["returnDraftIfExists": returnDraftIfExists]
        let request = JIRAWorkflowSchemesRouter(user: user,
                                                password: password,
                                                action: .getIssueType(id: id, issueType: issueType, params: parameters))
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
    
    public func setIssueType() {
        // TODO: Implement
    }
    
    /// Returns the workflow mappings or requested mapping to the caller for the passed scheme.
    public func getWorkflow(
        id: Int,
        workflowFilter: JIRAWorkflowMappingFilter? = nil,
        returnDraftIfExists: Bool = false,
        completion: @escaping (JIRAWorkflowMapping?) -> Void)
    {
        var parameters: Parameters = ["returnDraftIfExists": returnDraftIfExists]
        if let workflowFilter = workflowFilter {
            parameters["workflowName"] = workflowFilter.queryParameter()
        }
        let request = JIRAWorkflowSchemesRouter(user: user,
                                                password: password,
                                                action: .getWorkflow(id: id, params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode(JIRAWorkflowMapping.self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func deleteWorkflowMapping() {
        // TODO: Implement
    }
    
    public func updateWorkflowMapping() {
        // TODO: Implement
    }
}

public enum JIRAWorkflowMappingFilter {
    case workflowName(String)
    case all
    
    public func queryParameter() -> String? {
        switch self {
        case .workflowName(let name):
            return name
        case .all:
            return nil
        }
    }
}
