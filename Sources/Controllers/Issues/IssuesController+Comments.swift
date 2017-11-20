import Foundation
import Alamofire

public extension IssuesController {
    public func listIssueComments(
        number: Int,
        since: Date? = nil,
        completion: @escaping ([User]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        var parameters: Parameters = [:]
        if let date = since?.iso8601 {
            parameters["since"] = date
        }
        let request = IssuesCommentsRouter(user: user,
                                           password: password,
                                           owner: owner,
                                           repo: repo,
                                           action: .issueComments(number: number, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([User].self, from: data))
        }
    }
    
    public func listRepositoryComments(
        sort: SortComments = .created,
        direction: Direction? = nil,
        since: Date? = nil,
        completion: @escaping ([User]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        var parameters: Parameters = ["sort": sort]
        if let direction = direction {
            parameters["direction"] = direction.rawValue
        }
        if let date = since?.iso8601 {
            parameters["since"] = date
        }
        let request = IssuesCommentsRouter(user: user,
                                           password: password,
                                           owner: owner,
                                           repo: repo,
                                           action: .repositoryComments(params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([User].self, from: data))
        }
    }
    
    public func getComment(
        id: Int,
        completion: @escaping (User?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesCommentsRouter(user: user,
                                           password: password,
                                           owner: owner,
                                           repo: repo,
                                           action: .comment(id: id))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(User.self, from: data))
        }
    }
    
    public func createComment(
        number: Int,
        body: String,
        completion: @escaping (User?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let parameters: Parameters = ["body": body]
        let request = IssuesCommentsRouter(user: user,
                                           password: password,
                                           owner: owner,
                                           repo: repo,
                                           action: .createComment(number: number, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(User.self, from: data))
        }
    }
    
    public func editComment(
        id: Int,
        body: String,
        completion: @escaping (User?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let parameters: Parameters = ["body": body]
        let request = IssuesCommentsRouter(user: user,
                                           password: password,
                                           owner: owner,
                                           repo: repo,
                                           action: .editComment(id: id, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(User.self, from: data))
        }
    }
    
    public func deleteComment(
        id: Int,
        completion: @escaping (Bool) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(false)
            return
        }
        let request = IssuesCommentsRouter(user: user,
                                           password: password,
                                           owner: owner,
                                           repo: repo,
                                           action: .deleteComment(id: id))
        Alamofire.request(request)
            .validate(statusCode: 204..<205)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("Delete Successful")
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
                }
        }
    }
    
    public enum SortComments: String {
        case created
        case updated
    }
}
