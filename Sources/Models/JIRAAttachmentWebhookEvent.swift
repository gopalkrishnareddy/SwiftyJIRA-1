//
//  JIRAAttachmentWebhookEvent.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Issue Attachment Webhook Event
public struct JIRAAttachmentWebhookEvent: Codable {
    /// The timestamp of the event
    public var timestamp: Int?
    /// The type of the attachment webhook event
    public var webhookEvent: JIRAAttachmentEvent?
    /// The content of the issue attachment
    public var attachment: JIRAIssueAttachment?
}
