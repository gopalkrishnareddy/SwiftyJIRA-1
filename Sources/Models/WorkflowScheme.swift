import Foundation

public struct WorkflowSchemee: Codable {
    public var id: Int?
    public var name: String?
    public var defaultWorkflow: String?
//    public var issueTypeMappings: [String: String]?
    public var originalDefaultWorkflow: String?
    public var originalIssueTypeMappings: [String: String]?
    public var draft: Bool?
    public var lastModifiedUser: User?
    public var lastModified: String?
    public var `self`: String?
    public var updateDraftIfNeeded: Bool?
    public var issueTypes: [IssueType]?
}
