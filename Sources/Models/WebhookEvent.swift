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
    public var items: [[String: String?]]?
    public var id: String?
}
