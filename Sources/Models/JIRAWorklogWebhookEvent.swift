//
//  JIRAWorklogWebhookEvent.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Worklog Webhook Event
public struct JIRAWorklogWebhookEvent: Codable {
    public var timestamp: Int?
    public var webhookEvent: JIRAWorklogEvent?
}
