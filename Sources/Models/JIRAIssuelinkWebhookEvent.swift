//
//  JIRAIssuelinkWebhookEvent.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Issue Link Webhook Event
public struct JIRAIssuelinkWebhookEvent: Codable {
    public var issueLink: JIRAIssueLinkEventLink?
    public var timestamp: Int?
    public var webhookEvent: JIRAIssueLinkEvent?
}

/// JIRA Issue Link Event Link
public struct JIRAIssueLinkEventLink: Codable {
    public var sourceIssueId: Int?
    public var issueLinkType: JIRAIssueLinkType?
    public var systemLink: Bool?
    public var destinationIssueId: Int?
    public var id: Int?
}

/// JIRA Issue Link Type
public struct JIRAIssueLinkType: Codable {
    public var name: String?
    public var outwardName: String?
    public var isSystemLinkType: Bool?
    public var inwardName: String?
    public var isSubtaskLinkType: Bool?
    public var id: Int?
}
