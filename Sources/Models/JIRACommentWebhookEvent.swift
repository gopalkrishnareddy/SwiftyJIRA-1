//
//  JIRACommentWebhookEvent.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Issue Attachment Webhook Event
public struct JIRACommentWebhookEvent: Codable {
    /// The content of the comment
    public var comment: JIRACommentJSONBean?
    /// The timestamp of the event
    public var timestamp: Int?
    /// The type of the comment webhook event
    public var webhookEvent: JIRACommentEvent?
}
