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
    
    /// Creates multiple issues or sub-tasks from a JSON representation, in a single bulk operation.
    ///
    /// Creating a sub-task is similar to creating an issue
    ///
    /// - Parameters:
    ///   - body: JIRA Issues JSON representation
    ///   - updateHistory: If set to true, then project an issue was created in is added to the current user's project history. Project history is shown under Projects menu in Jira. By default the project history is not updated
    ///   - completion: Completion handler
    public func createIssues(
        body: JIRACreateIssuesBody,
        completion: @escaping ([JIRAIssue]?) -> Void)
    {
        let request = JIRAIssuesRouter(user: user,
                                       password: password,
                                       action: .createIssues(body: body))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([JIRAIssue].self, from: data))
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
    ///   - properties: Multi-value parameter defining the list of properties returned for the issue. Unlike `fields`, properties are not included in the response by default
    ///   - updateHistory: If set to true, adds the issue retrieved by this method to the current user’s issue history. Issue history is shown under Issues menu item in Jira, and is also used by `lastViewed` JQL field in an issue search. By default the issue history is not updated
    ///   - completion: Completion handler
    public func getIssue(
        issueIdOrKey: String,
        expand: [JIRAIssueExpandParameter]? = nil,
        fields: JIRAFieldParameter? = nil,
        properties: JIRAPropertyParameter? = nil,
        fieldsByKeys: Bool = false,
        updateHistory: Bool = false,
        completion: @escaping (JIRAIssue?) -> Void)
    {
        var parameters: Parameters = [
            "fieldsByKeys": fieldsByKeys,
            "updateHistory": updateHistory
        ]
        if let expand = expand {
            parameters["expand"] = expand
        }
        if let fields = fields {
            parameters["fields"] = fields.rawValue
        }
        if let properties = properties {
            parameters["properties"] = properties.stringValue()
        }
        let request = JIRAIssuesRouter(user: user,
                                       password: password,
                                       action: .getIssue(issueIdOrKey: issueIdOrKey, params: parameters))
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

    public func deleteIssue() {
        // TODO: Implement
    }
    
    public func editIssue() {
        // TODO: Implement
    }
    
    public func assignIssue() {
        // TODO: Implement
    }
    
    public func getEditIssueMetadata() {
        // TODO: Implement
    }
    
    public func notifyUsers() {
        // TODO: Implement
    }
    
    public func getRemoteIssueLinks() {
        // TODO: Implement
    }
    
    public func createUpdateRemoteIssueLink() {
        // TODO: Implement
    }
    
    public func deleteRemoteIssueLinkByGlobalID() {
        // TODO: Implement
    }
    
    public func getRemoteIssueLinkByID() {
        // TODO: Implement
    }
    
    public func updateRemoteIssueLink() {
        // TODO: Implement
    }
    
    public func deleteRemoteIssueLinkByID() {
        // TODO: Implement
    }
    
    public func doTransition() {
        // TODO: Implement
    }
    
    /// Returns a list of transitions available for this issue for the current user.
    ///
    /// Specify expand=transitions.fields parameter to retrieve the fields required for a transition together with their types.
    ///
    /// Fields metadata corresponds to the fields available in a transition screen for a particular transition. Fields hidden from the screen will not be returned in the metadata.
    ///
    public func getTransitions(
        issueIdOrKey: String,
        transitionId: String? = nil,
        skipRemoteOnlyCondition: Bool = false,
        completion: @escaping (JIRAIssueTransitions?) -> Void)
    {
        var parameters: Parameters = [
            "skipRemoteOnlyCondition": skipRemoteOnlyCondition
        ]
        if let transitionId = transitionId {
            parameters["transitionId"] = transitionId
        }
        let request = JIRAIssuesRouter(user: user,
                                       password: password,
                                       action: .getTransitions(issueIdOrKey: issueIdOrKey, params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(JIRAIssueTransitions.self, from: data))
        }
    }
    
    public func removeVote() {
        // TODO: Implement
    }
    
    public func addVote() {
        // TODO: Implement
    }
    
    public func getVotes() {
        // TODO: Implement
    }
    
    public func getIssueWatchers() {
        // TODO: Implement
    }
    
    public func addWatcher() {
        // TODO: Implement
    }
    
    public func removeWatcher() {
        // TODO: Implement
    }
    
    public func getCreateIssueMetadata() {
        // TODO: Implement
    }
    
    public func getIssuePickerResource() {
        // TODO: Implement
    }
}

/// Multi-value parameter defining the additional issue attributes to be included in the response. These attributes are not returned by default
public enum JIRAIssueExpandParameter: String, Codable {
    /// Field values rendered in HTML format
    case renderedFields
    /// Display name of each field
    case names
    /// Schema describing a field type
    case schema
    /// All possible transitions for the given issue
    case transitions
    /// All possibles operations available for the issue
    case operations
    /// Information about how each field may be edited
    case editmeta
    /// A list of recent updates of an issue, sorted by date, starting from the newest
    case changelog
    /// REST representations of all fields. Some fields may have multiple versions. REST representations are numbered. The greatest number always represents the most recent version. It is recommended to always use the most recent version. Once `expand=versionedRepresentations` parameter is provided in the request then `fields` field is excluded from the response
    case versionedRepresentations
}

/// Multi-value parameter defining the fields returned for the issue. By default, all fields are returned
public enum JIRAFieldParameter: String, Codable {
    /// Return all fields
    case all = "*all"
    /// Return navigable fields only
    case navigable = "*navigable"
    /// Return the summary and comments fields only
    case summaryComment = "summary,comment"
    /// Return all fields except comments
    case noComments = "*all,-comment"
}

/// Multi-value parameter defining the list of properties returned for the issue. Unlike fields, properties are not included in the response by default. Similarly to fields you can specify particular properties to be included in the response or exclude some of them using a `-` (minus) sign
public enum JIRAPropertyParameter {
    /// Return all properties
    case all
    /// Return all properties except specified properties
    case allExcluding(properties: [String])
    /// Return specified properties only
    case properties(properties: [String])
    
    public func stringValue() -> String {
        switch self {
        case .all:
            return "*all"
        case .allExcluding(var properties):
            properties = properties.map { "-\($0)" }
            properties.insert("*all", at: 0)
            return properties.joined(separator: ",")
        case .properties(let properties):
            return properties.joined(separator: ",")
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

public struct JIRACreateIssuesBody: Codable {
    public var issueUpdates: [JIRACreateIssueBody]?
}

public struct JIRAWorklog: Codable {
    public var worklog: [JIRAWorklogItems]?
}

public struct JIRAWorklogItems: Codable {
    public var add: [String: String]?
}
