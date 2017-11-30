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
    public var description: String?
    public var defaultWorkflow: String?
    public var issueTypeMappings: [String: String]?
    public var originalDefaultWorkflow: String?
    public var originalIssueTypeMappings: [String: String]?
    public var draft: Bool?
    public var lastModifiedUser: JIRAUserJSONBean?
    public var lastModified: String?
    public var `self`: URL?
    public var updateDraftIfNeeded: Bool?
    public var issueTypes: [JIRAIssueType]?
}

/// JIRA Workflow
public struct JIRAWorkflow: Codable {
    public var name: String?
    public var description: String?
    public var lastModifiedDate: String?
    public var lastModifiedUser: String?
    public var steps: Int?
    public var `default`: Bool?
}

public struct JIRAWorkflowMapping: Codable {
    public var workflow: String?
    public var issueTypes: [String]?
    public var defaultMapping: Bool?
}

public enum JIRAWorkflowMode: String, Codable {
    case draft
    case live
}
