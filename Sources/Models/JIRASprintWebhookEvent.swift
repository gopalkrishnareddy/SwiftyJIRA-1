//
//  JIRASprintWebhookEvent.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Sprint Webhook Event
public struct JIRASprintWebhookEvent: Codable {
    public var timestamp: Int?
    public var webhookEvent: JIRASprintEvent?
}
