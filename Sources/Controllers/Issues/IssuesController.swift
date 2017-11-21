import Foundation
import Dispatch
import Alamofire

// MARK: - General

public class IssuesController {

    private let queue = DispatchQueue(label: "SwiftyJIRA")
    let user: String
    let password: String
    public var owner: String?
    public var repo: String?
    public var org: String?
    
    public init(user: String, password: String, owner: String? = nil, repo: String? = nil, org: String? = nil) {
        self.user = user
        self.password = password
        self.owner = owner
        self.repo = repo
        self.org = org
    }

    public func getIssue(
        number: Int,
        completion: @escaping (Issue?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesRouter(user: user,
                                   password: password,
                                   owner: owner,
                                   repo: repo,
                                   action: .createIssue(params: [:]))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(try? JSONDecoder().decode(Issue.self, from: data))
        }
    }

    public func createIssue(
        title: String,
        body: String? = nil,
        milestone: String? = nil,
        labels: [String]? = nil,
        assignees: [String]? = nil,
        completion: @escaping (Issue?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        var parameters: Parameters = [
            "title": title
        ]
        if let body = body {
            parameters["body"] = body
        }
        if let milestone = milestone {
            parameters["milestone"] = milestone
        }
        if let labels = labels {
            parameters["labels"] = labels
        }
        if let assignees = assignees {
            parameters["assignees"] = assignees
        }
        let request = IssuesRouter(user: user,
                                   password: password,
                                   owner: owner,
                                   repo: repo,
                                   action: .createIssue(params: parameters))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(try? JSONDecoder().decode(Issue.self, from: data))
        }
    }

    public func editIssue(
        number: Int,
        title: String? = nil,
        body: String? = nil,
        state: State? = nil,
        milestone: MilestoneModification? = nil,
        labels: [String]? = nil,
        assignees: [String]? = nil,
        completion: @escaping (Issue?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        var parameters: Parameters = [:]
        if let title = title {
            parameters["title"] = title
        }
        if let body = body {
            parameters["body"] = body
        }
        if let state = state {
            parameters["state"] = state
        }
        if let milestone = milestone {
            parameters["milestone"] = milestone.value
        }
        if let labels = labels {
            parameters["labels"] = labels
        }
        if let assignees = assignees {
            parameters["assignees"] = assignees
        }
        let request = IssuesRouter(user: user,
                                   password: password,
                                   owner: owner,
                                   repo: repo,
                                   action: .createIssue(params: [:]))
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
            guard let data = response.data else {
                completion(nil)
                return
            }
            completion(try? JSONDecoder().decode(Issue.self, from: data))
        }
    }

    public func lockIssue(
        number: Int,
        completion: @escaping (Bool) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(false)
            return
        }
        let request = IssuesRouter(user: user,
                                   password: password,
                                   owner: owner,
                                   repo: repo,
                                   action: .createIssue(params: [:]))
        Alamofire.request(request)
            .validate(statusCode: 204..<205)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Lock Successful")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
        }
    }

    public func unlockIssue(
        number: Int,
        completion: @escaping (Bool) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(false)
            return
        }
        let request = IssuesRouter(user: user,
                                   password: password,
                                   owner: owner,
                                   repo: repo,
                                   action: .createIssue(params: [:]))
        Alamofire.request(request)
            .validate(statusCode: 204..<205)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Unlock Successful")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
        }
    }
    
    public enum Filter: String {
        case assigned
        case created
        case mentioned
        case subscribed
        case all
    }
    
    public enum State: String {
        case open
        case closed
        case all
    }
    
    public enum MilestoneModification {
        case number(Int)
        case remove
        
        var value: Int? {
            switch self {
            case .number(let num):
                return num
            case .remove:
                return nil
            }
        }
    }
    
    public enum SortIssues: String {
        case created
        case updated
        case comments
    }
}
