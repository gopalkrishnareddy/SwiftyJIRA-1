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

//    public func getIssue(
//        number: Int,
//        completion: @escaping (JIRAIssue?) -> Void)
//    {
//        let request = JIRAIssuesRouter(user: user,
//                                       password: password,
//                                       action: .createIssue(params: [:]))
//        Alamofire.request(request)
//            .validate()
//            .responseJSON { response in
//            guard let data = response.data else {
//                completion(nil)
//                return
//            }
//            completion(try? JSONDecoder().decode(JIRAIssue.self, from: data))
//        }
//    }

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
        var parameters: Parameters = ["updateHistory": updateHistory]
        if let update = body.update {
            parameters["update"] = update
        }
        if let fields = body.fields {
            parameters["fields"] = fields
        }
        let request = JIRAIssuesRouter(user: user,
                                       password: password,
                                       action: .createIssue(params: parameters))
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
}

public struct JIRAWorklog: Codable {
    public var worklog: [JIRAWorklogItems]?
}

public struct JIRAWorklogItems: Codable {
    public var add: [String: String]?
}
