import Foundation

public struct JIRACommentWebhookEvent: Codable {
    public var comment: JIRAIssueComment?
    public var timestamp: Int?
    public var webhookEvent: JIRACommentEvent?
}
