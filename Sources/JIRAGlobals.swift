//
//  JIRAGlobals.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation
import Dispatch

/// JIRA API base url
public let jiraBaseURL = "https://clowder.atlassian.net/rest/api/2"

let queue = DispatchQueue(label: "com.polka.cat.SwiftyJIRA")

public enum JIRASortOrder {
    case ascending(value: String)
    case descending(value: String)
    
    public func queryParam() -> [String: String] {
        switch self {
        case .ascending(let value):
            return ["orderBy": "+\(value)"]
        case .descending(let value):
            return ["orderBy": "-\(value)"]
        }
    }
}
