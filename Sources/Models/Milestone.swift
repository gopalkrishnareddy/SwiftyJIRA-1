import Foundation

public struct Milestone: Codable {
    public var url: String?
    public var html_url: String?
    public var labels_url: String?
    public var id: Int?
    public var number: Int?
    public var state: String?
    public var title: String?
    public var description: String?
    public var creator: User?
    public var open_issues: Int?
    public var closed_issues: Int?
    public var created_at: String?
    public var updated_at: String?
    public var closed_at: String?
    public var due_on: String?
}

public enum MilestoneFilter {
    case number(Int)
    case any
    case none

    public var stringValue: String {
        switch self {
        case .number(let n):
            return String(n)
        case .any:
            return "*"
        case .none:
            return "none"
        }
    }
}
