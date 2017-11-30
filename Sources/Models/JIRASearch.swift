//
//  JIRASearch.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/29/17.
//

import Foundation

public enum JIRAJQLValidation: String, Codable {
    case strict
    case warn
    case none
}

/// Multi-value parameter defining the fields returned for the issue.
public enum JIRASearchFieldParameter: String, Codable {
    /// Return all fields
    case all = "*all"
    /// Return navigable fields only
    case navigable = "*navigable"
    /// Return the summary and comments fields only
    case summaryComment = "summary,comment"
    /// Include navigable fields except the description
    case description = "-description"
    /// Return all fields except comments
    case noComments = "*all,-comment"
}

public struct JIRASearchProperties {
    public var property1: String?
    public var property2: String?
    public var property3: String?
    public var property4: String?
    public var property5: String?
    
    public func stringValue() -> String {
        let optionalProps = [property1, property2, property3, property4, property5]
        let props = optionalProps.filter{ $0 != nil }.map{ $0! }
        return props.joined(separator: ",")
    }
}

public struct JIRASearchResults: Codable {
    public var expand: String?
    public var startAt: Int?
    public var maxResults: Int?
    public var total: Int?
    public var issues: [JIRAIssue]?
    public var warningMessages: [String]?
}
