import Foundation

public struct JIRAIssueWebhookEvent: Codable {
    public var changelog: JIRAIssueWebhookEventChangelog?
    public var webhookEvent: String?
    public var issue_event_type_name: JIRAIssueEvent?
    public var timestamp: Int?
    public var user: JIRAUser?
    public var issue: JIRAIssue?
}

public struct JIRAIssueWebhookEventChangelog: Codable {
    public var items: [JIRAIssueWebhookChangelogItem]?
    public var id: String?
}

public struct JIRAIssueWebhookChangelogItem: Codable {
    public var from: String?
    public var field: String?
    public var toString: String?
    public var fieldtype: String?
    public var fieldId: String?
    public var to: String?
    public var fromString: String?
}
