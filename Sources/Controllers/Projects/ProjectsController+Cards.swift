import Foundation
import Alamofire

public extension ProjectsController {
    public func listProjectCards(
        columnId: Int,
        completion: @escaping ([ProjectCard]?) -> Void)
    {
        let request = ProjectsCardsRouter(user: user,
                                          password: password,
                                          action: .projectCards(columnId: columnId))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([ProjectCard].self, from: data))
        }
    }
    
    public func getProjectCard(
        id: Int,
        completion: @escaping (ProjectCard?) -> Void)
    {
        let request = ProjectsCardsRouter(user: user,
                                          password: password,
                                          action: .projectCard(id: id))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(ProjectCard.self, from: data))
        }
    }
    
    public func createProjectCard(
        columnId: Int,
        content: CardContent,
        completion: @escaping (ProjectCard?) -> Void)
    {
        
        let parameters: Parameters
        switch content {
        case .note(let content):
            parameters = ["note": content]
        case .content(let contentId, let contentType):
            parameters = [
                "content_id": contentId,
                "content_type": contentType.rawValue
            ]
        }
        let request = ProjectsCardsRouter(user: user,
                                          password: password,
                                          action: .createProjectCard(columnId: columnId, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(ProjectCard.self, from: data))
        }
    }
    
    public func updateProjectCard(
        id: Int,
        note: String,
        completion: @escaping (ProjectCard?) -> Void)
    {
        
        let parameters: Parameters = ["note": note]
        let request = ProjectsCardsRouter(user: user,
                                          password: password,
                                          action: .updateProjectCard(id: id, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(ProjectCard.self, from: data))
        }
    }
    
    public func deleteProjectCard(
        id: Int,
        completion: @escaping (Bool) -> Void)
    {
        let request = ProjectsCardsRouter(user: user,
                                          password: password,
                                          action: .deleteProjectCard(id: id))
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
    
    public func moveProjectCard(
        id: Int,
        position: CardPosition,
        columnId: Int? = nil,
        completion: @escaping (Bool) -> Void)
    {
        var parameters: Parameters = ["position": position.stringValue]
        if let columnId = columnId {
            parameters["column_id"] = columnId
        }
        let request = ProjectsCardsRouter(user: user,
                                          password: password,
                                          action: .moveProjectCard(id: id, params: parameters))
        Alamofire.request(request)
            .validate(statusCode: 201..<202)
            .responseJSON { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
        }
    }
    
    public enum CardContent {
        case note(String)
        case content(Int, CardContentType)
    }
    
    public enum CardContentType: String {
        case issue = "Issue"
    }
    
    public enum CardPosition {
        case top, bottom
        case after(Int)
        
        var stringValue: String {
            switch self {
            case .top:
                return "top"
            case .bottom:
                return "bottom"
            case .after(let id):
                return "after:\(id)"
            }
        }
    }
}
