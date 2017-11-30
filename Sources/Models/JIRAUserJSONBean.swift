//
//  JIRAUser.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA User
public struct JIRAUserJSONBean: Codable {
    public var `self`: URL?
    public var key: String?
    public var accountId: String?
    public var name: String?
    public var emailAddress: String?
    public var avatarUrls: [String: String]?
    public var displayName: String?
    public var active: Bool?
    public var timeZone: String?
    public var locale: String?
    public var groups: JIRASimpleListWrapper?
    public var applicationRoles: JIRASimpleListWrapper?
    public var expand: String?
}

/// JIRA Simple List Wrapper
public struct JIRASimpleListWrapper: Codable {
    public var size: Int?
    public var max_results: Int?
    public var items: [JIRAGroupJSONBean]?
}

/// JIRA Group JSON Bean
public struct JIRAGroupJSONBean: Codable {
    public var name: String?
    public var `self`: URL?
}

//public struct AvatarURL: Codable {
//    public var size: String?
//    public var url: String?
//}

