public struct User: Codable {
    public var login: String?
    public var id: Int?
    public var avatar_url: String?
    public var gravatar_id: String?
    public var url: String?
    public var html_url: String?
    public var followers_url: String?
    public var following_url: String?
    public var gists_url: String?
    public var starred_url: String?
    public var subscriptions_url: String?
    public var organizations_url: String?
    public var repos_url: String?
    public var events_url: String?
    public var received_events_url: String?
    public var type: String?
    public var site_admin: Bool?
}

public enum Assignee {
    case user(String)
    case none
    case any

    public var stringValue: String {
        switch self {
        case .user(let u):
            return u
        case .any:
            return "*"
        case .none:
            return "none"
        }
    }
}
