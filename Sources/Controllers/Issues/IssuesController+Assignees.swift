import Foundation
import Alamofire

// MARK: - Assignees

extension IssuesController {
    public func getAvailableAssignees(completion: @escaping ([User]?) -> Void) {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesAssigneesRouter(user: user,
                                            password: password,
                                            owner: owner,
                                            repo: repo,
                                            action: .availableAssignees)
        Alamofire.request(request)
            .validate()
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([User].self, from: data))
        }
    }
    
    public func checkAssignee(
        assignee: String,
        completion: @escaping (Bool) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(false)
            return
        }
        let request = IssuesAssigneesRouter(user: user,
                                            password: password,
                                            owner: owner,
                                            repo: repo,
                                            action: .checkAssignee(assignee: assignee))
        Alamofire.request(request)
            .validate(statusCode: 204..<205)
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
        }
    }
    
    public func addAssignees(
        number: Int,
        assignees: [String],
        completion: @escaping (Issue?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let parameters: Parameters = ["assignees": assignees]
        let request = IssuesAssigneesRouter(user: user,
                                            password: password,
                                            owner: owner,
                                            repo: repo,
                                            action: .addAssignees(number: number, params: parameters))
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
    
    public func removeAssignees(
        number: Int,
        assignees: [String],
        completion: @escaping (Issue?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let parameters: Parameters = ["assignees": assignees]
        let request = IssuesAssigneesRouter(user: user,
                                            password: password,
                                            owner: owner,
                                            repo: repo,
                                            action: .removeAssignees(number: number, params: parameters))
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
}

