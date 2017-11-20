import Foundation
import Alamofire

// MARK: - Events

extension IssuesController {
    public func listIssueEvents(
        number: Int,
        completion: @escaping ([IssueEvent]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesEventsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .issueEvents(number: number))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([IssueEvent].self, from: data))
        }
    }
    
    public func listRepositoryEvents(completion: @escaping ([IssueEvent]?) -> Void) {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesEventsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .repositoryEvents)
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([IssueEvent].self, from: data))
        }
    }
    
    public func getEvent(
        id: Int,
        completion: @escaping (IssueEvent?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesEventsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .event(id: id))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(IssueEvent.self, from: data))
        }
    }
}
