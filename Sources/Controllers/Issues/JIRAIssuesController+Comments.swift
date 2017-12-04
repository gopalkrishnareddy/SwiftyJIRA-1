//
//  JIRAIssuesController+Comments.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

extension JIRAIssuesController {
    public func addComment(
        issueIdOrKey: String,
        body: JIRACommentJSONBean,
        expand: [JIRAIssueCommentExpandParameter]? = nil,
        completion: @escaping (JIRACommentJSONBean?) -> Void)
    {
        var parameters: Parameters = [:]
        if let expand = expand {
            parameters["expand"] = expand
        }
        let request = JIRAIssuesCommentsRouter(user: user,
                                               password: password,
                                               action: .addComment(issueIdOrKey: issueIdOrKey,
                                                                   body: body,
                                                                   params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode(JIRACommentJSONBean.self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func getComments(
        issueIdOrKey: String,
        startAt: Int = 0,
        maxResults: Int = 50,
        orderBy: JIRAOrderBy? = nil,
        expand: JIRAIssueCommentExpandParameter? = nil,
        completion: @escaping ([JIRACommentJSONBean]?) -> Void)
    {
        var parameters: Parameters = [
            "startAt": startAt,
            "maxResults": maxResults
        ]
        if let orderBy = orderBy {
            parameters["orderBy"] = orderBy.stringValue
        }
        if let expand = expand {
            parameters["expand"] = expand
        }
        let request = JIRAIssuesCommentsRouter(user: user,
                                               password: password,
                                               action: .getComments(issueIdOrKey: issueIdOrKey, params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode([JIRACommentJSONBean].self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func updateComment(
        issueIdOrKey: String,
        commentId: String,
        body: JIRACommentJSONBean,
        expand: [JIRAIssueCommentExpandParameter]? = nil,
        completion: @escaping (JIRACommentJSONBean?) -> Void)
    {
        var parameters: Parameters = [:]
        if let expand = expand {
            parameters["expand"] = expand
        }
        let request = JIRAIssuesCommentsRouter(user: user,
                                               password: password,
                                               action: .updateComment(issueIdOrKey: issueIdOrKey,
                                                                      id: commentId,
                                                                      body: body,
                                                                      params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode(JIRACommentJSONBean.self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func deleteComment(
        issueIdOrKey: String,
        commentId: String,
        completion: @escaping (Bool) -> Void)
    {
        let request = JIRAIssuesCommentsRouter(user: user,
                                               password: password,
                                               action: .deleteComment(issueIdOrKey: issueIdOrKey, id: commentId))
        Alamofire.request(request)
            .validate(statusCode: 204..<205)
            .responseJSON(queue: queue) { response in
                switch response.result {
                case .success:
                    print("Comment Deletion Successful")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
        }
    }
    
    public func getComment(
        issueIdOrKey: String,
        commentId: String,
        expand: [JIRAIssueCommentExpandParameter]? = nil,
        completion: @escaping (JIRACommentJSONBean?) -> Void)
    {
        var parameters: Parameters = [:]
        if let expand = expand {
            parameters["expand"] = expand
        }
        let request = JIRAIssuesCommentsRouter(user: user,
                                               password: password,
                                               action: .getComment(issueIdOrKey: issueIdOrKey,
                                                                   id: commentId,
                                                                   params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode(JIRACommentJSONBean.self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
}

/// Multi-value parameter defining the additional issue attributes to be included in the response. These attributes are not returned by default
public enum JIRAIssueCommentExpandParameter: String, Codable {
    /// Provides body rendered in HTML
    case renderedBody
}
