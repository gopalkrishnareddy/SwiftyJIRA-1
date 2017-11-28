//
//  JIRACommentJSONBean.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/25/17.
//

import Foundation

/// JIRA Comment JSON Bean
public struct JIRACommentJSONBean: Codable {
    public var author: JIRAUserJSONBean?
    public var id: String?
    public var created: String?
    public var updateAuthor: JIRAUserJSONBean?
    public var updated: String?
    public var `self`: URL?
    public var body: String?
    public var properties: [JIRAEntityPropertyBean]?
    public var renderedBody: String?
    public var visibility: JIRAVisibilityJSONBean?
}

public struct JIRAEntityPropertyBean: Codable {
    
}

public struct JIRAVisibilityJSONBean: Codable {
    public var type: JIRAVisibilityJSONBeanType?
    public var value: String?
}

public enum JIRAVisibilityJSONBeanType: String, Codable {
    case group
    case role
}
