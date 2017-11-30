//
//  JIRASearchController.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/29/17.
//

import Foundation
import Dispatch
import Alamofire

/// The controller class for the JIRA Search REST API
public class JIRASearchController {
    
    /// JIRA user
    let user: String
    /// JIRA password
    let password: String
    
    private let queue = DispatchQueue(label: "com.polka.cat.SwiftyJIRA")
    
    /// Create instance of `JIRASearchController`
    ///
    /// - Parameters:
    ///   - user: JIRA user
    ///   - password: JIRA password
    public init(user: String, password: String) {
        self.user = user
        self.password = password
    }
    
    public func search(
        jql: String,
        completion: @escaping (JIRASearchResults?) -> Void)
    {
        let request = JIRASearchRouter(user: user,
                                       password: password,
                                       action: .searchUsingSearchRequest(request: jql))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(JIRASearchResults.self, from: data))
        }
    }
    
    public func search(
        jql: String,
        startAt: Int,
        maxResults: Int = 50,
        validateQuery: JIRAJQLValidation = .strict,
        fields: JIRASearchFieldParameter? = nil,
        expand: String? = nil,
        properties: JIRASearchProperties? = nil,
        fieldsByKeys: Bool = false,
        completion: @escaping (JIRASearchResults?) -> Void)
    {
        var parameters: Parameters = [
            "jql": jql,
            "startAt": startAt,
            "maxResults": maxResults,
            "validateQuery": validateQuery,
            "fieldsByKeys": fieldsByKeys
        ]
        if let fields = fields {
            parameters["fields"] = fields.rawValue
        }
        if let expand = expand {
            parameters["expand"] = expand
        }
        if let properties = properties {
            parameters["properties"] = properties.stringValue()
        }
        let request = JIRASearchRouter(user: user,
                                       password: password,
                                       action: .search(params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(JIRASearchResults.self, from: data))
        }
    }
}

