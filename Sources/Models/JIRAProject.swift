//
//  JIRAProject.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Project
public struct JIRAProject: Codable {
    public var `self`: URL?
    public var name: String?
    public var avatarUrls: [String: String]?
    public var id: String?
    public var key: String?
    public var description: String?
    public var lead: JIRAUserJSONBean?
    public var components: [JIRAProjectComponent]?
    public var issueTypes: [JIRAIssueType]?
    public var url: URL?
    public var email: String?
    public var assigneeType: JIRAassigneeType?
    public var versions: [JIRAVersion]?
    public var roles: [String: URL]?
    public var projectCategory: JIRAProjectCategory?
    public var simplified: Bool?
}

/// JIRA Project Category
public struct JIRAProjectCategory: Codable {
    public var `self`: URL?
    public var id: String?
    public var name: String?
    public var description: String?
}

public struct JIRAProjectComponent: Codable {
    public var `self`: URL?
    public var id: String?
    public var name: String?
    public var description: String?
    public var lead: JIRAUserJSONBean?
    public var assigneeType: JIRAassigneeType?
    public var assignee: JIRAUserJSONBean?
    public var realAssigneeType: JIRAassigneeType?
    public var realAssignee: JIRAUserJSONBean?
    public var isAssigneeTypeValid: Bool?
    public var project: String?
    public var projectId: Int?
}

public enum JIRAassigneeType: String, Codable {
    case PROJECT_LEAD
}
