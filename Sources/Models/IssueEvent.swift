import Foundation

public struct IssueEvent: Codable {
    public var id: Int?
    public var url: String?
    public var actor: User?
    public var commit_id: String?
    public var commit_url: String?
    public var event: EventType?
    public var created_at: String?
    public var label: String?
    public var assignee: User?
    public var assigner: User?
    public var review_requester: User?
    public var requested_reviewers: [User]?
    public var dismissed_review: DismissedReview?
    public var milestone: Milestone?
    public var rename: Rename?
    public var issue: Issue?

    public enum EventType: String, Codable {
        case closed
        case reopened
        case subscribed
        case merged
        case referenced
        case mentioned
        case assigned
        case unassigned
        case labeled
        case unlabeled
        case milestoned
        case demilestoned
        case renamed
        case locked
        case unlocked
        case head_ref_deleted
        case head_ref_restored
        case review_dismissed
        case review_requested
        case review_request_removed
        case marked_as_duplicate
        case unmarked_as_duplicate
        case added_to_project
        case moved_columns_in_project
        case removed_from_project
        case converted_note_to_issue
    }
}

public struct DismissedReview: Codable {
    public var review_id: String?
    public var state: String?
    public var dismissal_message: String?
}

public struct Rename: Codable {
    public var from: String?
    public var to: String?
}
