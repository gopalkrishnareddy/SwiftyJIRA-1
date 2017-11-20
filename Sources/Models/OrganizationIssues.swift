import Foundation

public struct OrganizationIssues: Codable {
    public var id: Int?
    public var url: String?
    public var repository_url: String?
    public var labels_url: String?
    public var comments_url: String?
    public var events_url: String?
    public var html_url: String?
    public var number: Int?
    public var state: String?
    public var title: String?
    public var body: String?
    public var user: User?
    public var labels: [Label]?
    public var assignee: User?
    public var assignees: [User]?
    public var milestone: Milestone?
    public var locked: Bool?
    public var comments: Int?
    public var pull_request: PullRequest?
    public var closed_at: String?
    public var created_at: String?
    public var updated_at: String?
    public var repository: Repository?
}
