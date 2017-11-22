import Foundation

public struct JIRASprintWebhookEvent: Codable {
    public var timestamp: Int?
    public var webhookEvent: JIRASprintEvent?
}
