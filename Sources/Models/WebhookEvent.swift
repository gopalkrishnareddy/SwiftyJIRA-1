import Foundation

public struct WebhookEvent: Codable {
    public var webhookEvent: String?
    public var issue_event_type_name: IssueEvent?
    public var timestamp: Int?
    public var user: User?
    public var issue: Issue?
}
