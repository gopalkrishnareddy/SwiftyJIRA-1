import Foundation

public struct Issue: Codable {
    public var expand: String?
    public var id: String?
    public var `self`: String?
    public var key: String?
    public var renderedFields: [String]?
    public var properties: [String]?
    public var names: [String]?
    public var schema: [String]?
    public var transitions: [Transition]?
    public var operations: [Opsbar]?
    public var editmeta: EditMeta?
    public var changelog: Changelog?
    public var versionedRepresentations: [String: String]?
    public var fieldsToInclude: [Field]?
    public var fields: [Field]?
}

public struct IssueType: Codable {
    public var `self`: String?
    public var id: String?
    public var description: String?
    public var iconUrl: String?
    public var name: String?
    public var subtask: Bool?
    public var avatarId: Int?
}

public struct Transition: Codable {
    public var id: String?
    public var name: String?
    public var to: Status?
    public var hasScreen: Bool?
    public var isGlobal: Bool?
    public var isInitial: Bool?
    public var isConditional: Bool?
    public var fields: [FieldMeta]?
}

public struct Status: Codable {
    public var `self`: String
    public var statusColor: String?
    public var description: String?
    public var iconUrl: String?
    public var name: String?
    public var id: String
    public var statusCategory: StatusCategory?
}

public struct StatusCategory: Codable {
    public var `self`: String?
    public var id: Int?
    public var key: String?
    public var colorName: String?
    public var name: String?
}

public struct Opsbar: Codable {
    public var linkGroups: [LinkGroup]?
}

public struct EditMeta: Codable {
    public var fields: FieldMeta?
}

public struct Changelog: Codable {
    public var startAt: Int?
    public var maxResults: Int?
    public var total: Int?
    public var histories: [ChangeHistory]?
}

public struct Field: Codable {
    
}

public struct FieldMeta: Codable {
    public var required: Bool?
    public var schema: Schema?
    public var name: String?
    public var key: String?
    public var autoCompleteUrl: String?
    public var hasDefaultValue: Bool?
    public var operations: [String]?
//    public var allowedValues: [String]?
}

public struct LinkGroup: Codable {
    public var id: String?
    public var styleClass: String?
    public var header: SimpleLink?
    public var weight: Int?
    public var links: [SimpleLink]?
    public var groups: [LinkGroup]?
}

public struct SimpleLink: Codable {
    public var id: String?
    public var styleClass: String?
    public var iconClass: String?
    public var label: String?
    public var title: String?
    public var href: String?
    public var weight: Int?
}

public struct Schema: Codable {
    
}

public struct ChangeHistory: Codable {
    public var id: String?
    public var author: User?
    public var created: String?
    public var items: [ChangeItem]?
    public var historyMetadata: HistoryMetadata?
}

public struct ChangeItem: Codable {
    public var field: String?
    public var fieldType: String?
    public var fieldId: String?
    public var from: String?
    public var fromString: String?
    public var to: String?
    public var toString: String?
}

public struct HistoryMetadata: Codable {
    public var type: String?
    public var description: String?
    public var descriptionKey: String?
    public var activityDescription: String?
    public var activityDescriptionKey: String?
    public var emailDescription: String?
    public var emailDescriptionKey: String?
    public var actor: HistoryMetadataParticipant?
    public var generator: HistoryMetadataParticipant?
    public var cause: HistoryMetadataParticipant?
//    public var extraData: [String]?
}

public struct HistoryMetadataParticipant: Codable {
    public var id: String?
    public var displayName: String?
    public var displayNameKey: String?
    public var type: String?
    public var avatarUrl: String?
    public var url: String?
}
