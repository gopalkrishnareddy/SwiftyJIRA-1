import Foundation

public enum JIRAIssueEvent: String, Codable {
    case issue_updated
    case issue_created
    case issue_deleted
}

public enum JIRACommentEvent: String, Codable {
    case comment_updated
    case comment_created
    case comment_deleted
}

public enum JIRAIssueLinkEvent: String, Codable {
    case issuelink_created
    case issuelink_deleted
}
