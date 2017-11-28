//
//  JIRARemoteLink.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/26/17.
//

import Foundation

public struct JIRARemoteLink: Codable {
    public var globalId: String?
    public var relationship: String?
    public var object: JIRAObject?
}

public struct JIRAObject: Codable {
    public var url: URL?
    public var title: String?
    public var summary: String?
    public var icon: JIRAObjectIcon?
    public var application: JIRAObjectApplication?
}

public struct JIRAObjectStatus: Codable {
    public var resolved: Bool?
    public var icon: JIRAObjectIcon?
}

public struct JIRAObjectIcon: Codable {
    public var url16x16: URL?
    public var title: String?
    public var link: String?
}

public struct JIRAObjectApplication: Codable {
    public var name: String?
    public var type: String?
}
