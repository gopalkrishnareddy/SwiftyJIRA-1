import Foundation
import Alamofire

extension IssuesController {
    public func listIssueTimelineEvents(
        number: Int,
        completion: @escaping ([IssueEvent]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesTimelineRouter(user: user,
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
}
