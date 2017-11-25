//
//  JIRAEvents.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

public enum JIRAIssueEvent: String, Codable {
    case issue_updated
    case issue_created
    case issue_deleted
    case issue_worklog_changed
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

public enum JIRAAttachmentEvent: String, Codable {
    case attachment_created
    case attachment_deleted
}

public enum JIRASprintEvent: String, Codable {
    case sprint_created
    case sprint_deleted
    case sprint_updated
    case sprint_started
    case sprint_closed
}

public enum JIRAWorklogEvent: String, Codable {
    case worklog_created
    case worklog_deleted
    case worklog_updated
}
