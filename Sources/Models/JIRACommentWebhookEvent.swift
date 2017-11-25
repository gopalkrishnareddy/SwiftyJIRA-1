//
//  JIRACommentWebhookEvent.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

public struct JIRACommentWebhookEvent: Codable {
    public var comment: JIRAIssueComment?
    public var timestamp: Int?
    public var webhookEvent: JIRACommentEvent?
}
