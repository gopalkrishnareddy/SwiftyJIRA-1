//
//  JIRAIssuesController.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/16/17.
//

import Foundation
import Dispatch
import Alamofire

/// The controller class for the JIRA issues REST API
public class JIRAIssuesController {
    
    /// JIRA user
    let user: String
    /// JIRA password
    let password: String
    
    private let queue = DispatchQueue(label: "com.polka.cat.SwiftyJIRA")
    
    /// Create instance of `JIRAIssuesController`
    ///
    /// - Parameters:
    ///   - user: JIRA user
    ///   - password: JIRA password
    public init(user: String, password: String) {
        self.user = user
        self.password = password
    }
    
    /// Creates an issue or a sub-task from a JSON representation.
    ///
    /// You can provide two parameters in request's body: `update` or `fields`. The fields, that can be set on an issue create operation, can be determined using the `/rest/api/2/issue/createmeta` resource. If a particular field is not configured to appear on the issue's Create screen, then it will not be returned in the createmeta response. A field validation error will occur if such field is submitted in request.
    ///
    /// Creating a sub-task is similar to creating an issue with the following differences:
    ///
    /// `issueType` field must be set to a sub-task issue type (use `/issue/createmeta` to find sub-task issue types), and
    /// You must provide a `parent` field with the ID or key of the parent issue
    ///
    /// - Parameters:
    ///   - body: JIRA Issue JSON representation
    ///   - updateHistory: If set to true, then project an issue was created in is added to the current user's project history. Project history is shown under Projects menu in Jira. By default the project history is not updated
    ///   - completion: Completion handler
    public func createIssue(
        body: JIRACreateIssueBody,
        updateHistory: Bool = false,
        completion: @escaping (JIRAIssue?) -> Void)
    {
        let parameters: Parameters = ["updateHistory": updateHistory]
        let request = JIRAIssuesRouter(user: user,
                                       password: password,
                                       action: .createIssue(body: body, params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(try? JSONDecoder().decode(JIRAIssue.self, from: data))
        }
    }
    
    /// Returns a full representation of the issue for the given issue key.
    ///
    /// The issue JSON consists of the issue key and a collection of fields. Additional information like links to workflow transition sub-resources, or HTML rendered values of the fields supporting HTML rendering can be retrieved with `expand` request parameter specified.
    ///
    /// The `fields` request parameter accepts a comma-separated list of fields to include in the response. It can be used to retrieve a subset of fields. By default all fields are returned in the response. A particular field can be excluded from the response if prefixed with a `-` (minus) sign. Parameter can be provided multiple times on a single request.
    ///
    /// By default, all fields are returned in the response. Note: this is different from a JQL search - only navigable fields are returned by default (`*navigable`).
    ///
    /// - Parameters:
    ///   - issueIdOrKey: ID or key of the issue, for example: JRACLOUD-1549. If exact match is not found then Jira will perform a case-insensitive search, and check for moved issues. In both scenarios the request will be processed as usual (a 302 or other redirect status will not be returned). The issue key returned in the response will indicate the current value of issue’s key
    ///   - expand: Multi-value parameter defining the additional issue attributes to be included in the response. These attributes are not returned by default
    ///   - fields: Multi-value parameter defining the fields returned for the issue. By default, all fields are returned
    ///   - fieldsByKeys: If true then issue fields are referenced by keys instead of IDs
    ///   - properties: Multi-value parameter defining the list of properties returned for the issue. Unlike `fields`, properties are not included in the response by default. Similarly to `fields` you can specify particular properties to be included in the response or exclude some of them using a `-` (minus) sign
    ///   - updateHistory: If set to true, adds the issue retrieved by this method to the current user’s issue history. Issue history is shown under Issues menu item in Jira, and is also used by `lastViewed` JQL field in an issue search. By default the issue history is not updated
    ///   - completion: Completion handler
    public func getIssue(
        issueIdOrKey: String,
        expand: String,
        fields: String,
        fieldsByKeys: Bool = false,
        properties: String,
        updateHistory: Bool = false,
        completion: @escaping (JIRAIssue?) -> Void)
    {
        let request = JIRAIssuesRouter(user: user,
                                       password: password,
                                       action: .getIssue(issueIdOrKey: issueIdOrKey, params: [:]))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(JIRAIssue.self, from: data))
        }
    }

}

public struct JIRACreateIssueBody: Codable {
    public var update: JIRAWorklog?
    public var fields: JIRAIssueFields?
    public var historyMetadata: JIRAHistoryMetadata?
    public var properties: JIRAEntityPropertyBean?
    public var transition: JIRATransitionBean?
}

public struct JIRAWorklog: Codable {
    public var worklog: [JIRAWorklogItems]?
}

public struct JIRAWorklogItems: Codable {
    public var add: [String: String]?
}
