//
//  JIRAIssueLinksController.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation

/// The controller class for the JIRA issue links REST API
public class JIRAIssueLinksController {
    
    /// JIRA user
    let user: String
    /// JIRA password
    let password: String
    
    /// Create instance of `JIRAIssuesController`
    ///
    /// - Parameters:
    ///   - user: JIRA user
    ///   - password: JIRA password
    public init(user: String, password: String) {
        self.user = user
        self.password = password
    }
    
}
