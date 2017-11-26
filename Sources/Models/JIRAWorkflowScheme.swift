//
//  JIRAWorkflowScheme.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Workflow Scheme
public struct JIRAWorkflowScheme: Codable {
    public var id: Int?
    public var name: String?
    public var defaultWorkflow: String?
//    public var issueTypeMappings: [String: String]?
    public var originalDefaultWorkflow: String?
    public var originalIssueTypeMappings: [String: String]?
    public var draft: Bool?
    public var lastModifiedUser: JIRAUserJSONBean?
    public var lastModified: String?
    public var `self`: String?
    public var updateDraftIfNeeded: Bool?
    public var issueTypes: [JIRAIssueType]?
}
