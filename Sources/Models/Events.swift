import Foundation

public enum IssueEvent: String, Codable {
    case issue_updated
    case issue_created
    case issue_deleted
}

public enum CommentEvent: String, Codable {
    case comment_updated
    case comment_created
    case comment_deleted
}

public enum IssueLinkEvent: String, Codable {
    case issuelink_created
    case issuelink_deleted
}
