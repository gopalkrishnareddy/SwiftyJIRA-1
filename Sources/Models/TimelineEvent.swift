import Foundation

public struct TimelineEvent: Codable {
    public var id: Int?
    public var url: String?
    public var actor: User?
    public var commit_id: String?
    public var event: EventType?
    public var created_at: String?
    public var label: Label?
    public var assignee: User?
    public var milestone: Milestone?
    public var source: Source?
    public var rename: Rename?

    public enum EventType: String, Codable {
        case added_to_project
        case assigned
        case closed
        case commented
        case committed
        case converted_note_to_issue
        case cross_referenced
        case demilestoned
        case head_ref_deleted
        case head_ref_restored
        case labeled
        case locked
        case marked_as_duplicate
        case mentioned
        case merged
        case milestoned
        case moved_columns_in_project
        case referenced
        case removed_from_project
        case renamed
        case reopened
        case review_dismissed
        case review_requested
        case review_request_removed
        case subscribed
        case unassigned
        case unlabeled
        case unlocked
        case unmarked_as_duplicate
        case unsubscribed
    }

    public struct Source: Codable {
        public var id: Int?
        public var actor: User?
        public var url: String?
    }
}
