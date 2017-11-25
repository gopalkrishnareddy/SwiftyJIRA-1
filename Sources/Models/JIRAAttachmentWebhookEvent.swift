//
//  JIRAAttachmentWebhookEvent.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

public struct JIRAAttachmentWebhookEvent: Codable {
    public var timestamp: Int?
    public var webhookEvent: JIRACommentEvent?
    public var attachment: JIRAIssueAttachment?
}
