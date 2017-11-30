//
//  JIRAEvents.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation

/// JIRA Issue Event
public enum JIRAIssueEvent: String, Codable {
    /// Issue updated
    case issue_generic
    /// Issue updated
    case issue_updated
    /// Issue created
    case issue_created
    /// Issue deleted
    case issue_deleted
    /// Issue worklog changed
    case issue_worklog_changed
}

/// JIRA Comment Event
public enum JIRACommentEvent: String, Codable {
    /// Comment updated
    case comment_updated
    /// Comment created
    case comment_created
    /// Comment deleted
    case comment_deleted
}

/// JIRA Issue Link Event
public enum JIRAIssueLinkEvent: String, Codable {
    /// Issue link created
    case issuelink_created
    /// Issue link deleted
    case issuelink_deleted
}

/// JIRA Attachment Event
public enum JIRAAttachmentEvent: String, Codable {
    /// Attachment created
    case attachment_created
    /// Attachment deleted
    case attachment_deleted
}

/// JIRA Sprint Event
public enum JIRASprintEvent: String, Codable {
    /// Sprint created
    case sprint_created
    /// Sprint deleted
    case sprint_deleted
    /// Sprint updated
    case sprint_updated
    /// Sprint started
    case sprint_started
    /// Sprint closed
    case sprint_closed
}

/// JIRA Worklog Event
public enum JIRAWorklogEvent: String, Codable {
    /// Worklog created
    case worklog_created
    /// Worklog deleted
    case worklog_deleted
    /// Worklog updated
    case worklog_updated
}
