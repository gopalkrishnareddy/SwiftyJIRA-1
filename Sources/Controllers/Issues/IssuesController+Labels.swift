import Foundation
import Alamofire

// MARK: - Labels

extension IssuesController {
    public func listAllLabels(completion: @escaping ([Label]?) -> Void) {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .allLabels)
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([Label].self, from: data))
        }
    }
    
    public func getLabel(
        name: String,
        completion: @escaping (Label?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .label(name: name))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(Label.self, from: data))
        }
    }
    
    public func createLabel(
        name: String,
        color: HexColor,
        completion: @escaping (Label?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let parameters: Parameters = [
            "name": name,
            "color": color.value
        ]
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .createLabel(params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(Label.self, from: data))
        }
    }
    
    public func updateLabel(
        name: String,
        newName: String? = nil,
        color: HexColor? = nil,
        completion: @escaping (Label?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        var parameters: Parameters = [:]
        if let newName = newName {
            parameters["name"] = newName
        }
        if let color = color {
            parameters["color"] = color.value
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .updateLabel(name: name, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(Label.self, from: data))
        }
    }
    
    public func deleteLabel(
        name: String,
        completion: @escaping (Bool) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(false)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .deleteLabel(name: name))
        Alamofire.request(request)
            .responseJSON { response in
                guard let _ = response.data else {
                    completion(false)
                    return
                }
                completion(true)
        }
    }
    
    public func listIssueLabels(
        number: Int,
        completion: @escaping ([Label]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .issueLabels(number: number))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([Label].self, from: data))
        }
    }
    
    public func addIssueLabels(
        number: Int,
        labels: [String],
        completion: @escaping ([Label]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .addLabels(number: number, params: labels.asParameters()))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([Label].self, from: data))
        }
    }
    
    public func removeIssueLabel(
        number: Int,
        name: String,
        completion: @escaping ([Label]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .removeLabel(number: number, name: name))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([Label].self, from: data))
        }
    }
    
    public func replaceIssueLabels(
        number: Int,
        labels: [String],
        completion: @escaping ([Label]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .replaceLabels(number: number, params: labels.asParameters()))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([Label].self, from: data))
        }
    }
    
    public func removeAllLabels(
        number: Int,
        completion: @escaping (Bool) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(false)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .removeAllLabels(number: number))
        Alamofire.request(request)
            .responseJSON { response in
                guard let _ = response.data else {
                    completion(false)
                    return
                }
                completion(true)
        }
    }
    
    public func getAllMilestoneLabels(
        number: Int,
        completion: @escaping ([Label]?) -> Void)
    {
        guard let owner = owner, let repo = repo else {
            completion(nil)
            return
        }
        let request = IssuesLabelsRouter(user: user,
                                         password: password,
                                         owner: owner,
                                         repo: repo,
                                         action: .milestoneLabels(number: number))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([Label].self, from: data))
        }
    }
}
