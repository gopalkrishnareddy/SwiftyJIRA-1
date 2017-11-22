import Foundation

public struct JIRAAttachmentWebhookEvent: Codable {
    public var timestamp: Int?
    public var webhookEvent: JIRACommentEvent?
    public var attachment: JIRAIssueAttachment?
}
