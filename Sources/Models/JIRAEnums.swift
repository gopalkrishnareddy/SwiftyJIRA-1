//
//  JIRAEnums.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/24/17.
//

import Foundation

/// How to order results
public enum JIRAOrderBy {
    
    /// Ascending by field
    case ascending(field: String)
    /// Descending by field
    case descending(field: String)
    
    /// The string representation of the ordering
    var stringValue: String {
        switch self {
        case .ascending(let field):
            return "?orderBy=+\(field)"
        case .descending(let field):
            return "?orderBy=-\(field)"
        }
    }
}
