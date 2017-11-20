import Foundation
import Alamofire

// MARK: - Milestones

extension IssuesController {
    public func listRepositoryMilestones(
        state: MilestonesState = .open,
        sort: SortMilestones = .due_on,
        direction: Direction = .asc,
        completion: @escaping ([Milestone]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let parameters: Parameters = [
            "state": state.rawValue,
            "sort": sort,
            "direction": direction
        ]
        let request = IssuesMilestonesRouter(user: user,
                                             password: password,
                                             owner: owner,
                                             repo: repo,
                                             action: .repositoryMilestones(params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([Milestone].self, from: data))
        }
    }
    
    public func getMilestone(
        number: Int,
        completion: @escaping (Milestone?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesMilestonesRouter(user: user,
                                             password: password,
                                             owner: owner,
                                             repo: repo,
                                             action: .milestone(number: number))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(Milestone.self, from: data))
        }
    }
    
    public func createMilestone(
        title: String,
        state: MilestoneState = .open,
        description: String? = nil,
        dueOn: Date? = nil,
        completion: @escaping (Milestone?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        var parameters: Parameters = [
            "title": title,
            "state": state.rawValue
        ]
        if let description = description {
            parameters["description"] = description
        }
        if let date = dueOn?.iso8601 {
            parameters["due_on"] = date
        }
        let request = IssuesMilestonesRouter(user: user,
                                             password: password,
                                             owner: owner,
                                             repo: repo,
                                             action: .createMilestone(params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(Milestone.self, from: data))
        }
    }
    
    public func updateMilestone(
        number: Int,
        title: String? = nil,
        state: MilestoneState = .open,
        description: String? = nil,
        dueOn: Date? = nil,
        completion: @escaping (Milestone?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        var parameters: Parameters = ["state": state.rawValue]
        if let title = title {
            parameters["title"] = title
        }
        if let description = description {
            parameters["description"] = description
        }
        if let date = dueOn?.iso8601 {
            parameters["due_on"] = date
        }
        let request = IssuesMilestonesRouter(user: user,
                                             password: password,
                                             owner: owner,
                                             repo: repo,
                                             action: .updateMilestone(number: number, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(Milestone.self, from: data))
        }
    }
    
    public func deleteMilestone(
        number: Int,
        completion: @escaping (Bool) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(false)
            return
        }
        let request = IssuesMilestonesRouter(user: user,
                                             password: password,
                                             owner: owner,
                                             repo: repo,
                                             action: .deleteMilestone(number: number))
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
    
    public enum SortMilestones: String {
        case completeness
        case due_on
    }
    
    public enum MilestonesState: String {
        case all
        case open
        case closed
    }
    
    public enum MilestoneState: String {
        case open
        case closed
    }
}
