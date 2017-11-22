import Foundation

public struct JIRAWorklogWebhookEvent: Codable {
    public var timestamp: Int?
    public var webhookEvent: JIRAWorklogEvent?
}
