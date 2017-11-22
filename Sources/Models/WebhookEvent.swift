import Foundation

public struct WebhookEvent: Codable {
    public var changelog: WebhookEventChangelog?
    public var webhookEvent: String?
    public var issue_event_type_name: IssueEvent?
    public var timestamp: Int?
    public var user: User?
    public var issue: Issue?
}

public struct WebhookEventChangelog: Codable {
    public var items: [WebhookChangelogItem]?
    public var id: String?
}

public struct WebhookChangelogItem: Codable {
    public var from: String?
    public var field: String?
    public var toString: String?
    public var fieldtype: String?
    public var fieldId: String?
    public var to: String?
    public var fromString: String?
}
