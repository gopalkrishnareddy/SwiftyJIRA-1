import Foundation

public struct Comment: Codable {
    public var id: Int?
    public var url: String?
    public var html_url: String?
    public var body: String?
    public var user: User?
    public var created_at: String?
    public var updated_at: String?
}

