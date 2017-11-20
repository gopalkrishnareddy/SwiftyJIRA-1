import Foundation

public struct Project: Codable {
    public var owner_url: String?
    public var url: String?
    public var html_url: String?
    public var columns_url: String?
    public var id: Int?
    public var name: String?
    public var body: String?
    public var number: Int?
    public var state: String?
    public var creator: User?
    public var created_at: String?
    public var updated_at: String?
}
