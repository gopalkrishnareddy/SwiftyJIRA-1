//
//  JIRAProject.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Project
public struct JIRAProject: Codable {
    public var `self`: String?
    public var name: String?
    public var avatarUrls: [String: String]?
    public var id: String?
    public var key: String?
}
