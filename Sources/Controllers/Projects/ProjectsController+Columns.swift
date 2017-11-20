import Foundation
import Alamofire

public extension ProjectsController {
    public func listProjectColumns(
        projectId: Int,
        completion: @escaping ([ProjectColumn]?) -> Void)
    {
        let request = ProjectsColumnsRouter(user: user,
                                            password: password,
                                            action: .projectColumns(projectId: projectId))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode([ProjectColumn].self, from: data))
        }
    }
    
    public func getProjectColumn(
        id: Int,
        completion: @escaping (ProjectColumn?) -> Void)
    {
        let request = ProjectsColumnsRouter(user: user,
                                            password: password,
                                            action: .projectColumn(id: id))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(ProjectColumn.self, from: data))
        }
    }
    
    public func createProjectColumn(
        projectId: Int,
        name: String,
        completion: @escaping (ProjectColumn?) -> Void)
    {
        let parameters: Parameters = ["name": name]
        let request = ProjectsColumnsRouter(user: user,
                                            password: password,
                                            action: .createProjectColumn(projectId: projectId, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(ProjectColumn.self, from: data))
        }
    }
    
    public func updateProjectColumn(
        id: Int,
        name: String,
        completion: @escaping (ProjectColumn?) -> Void)
    {
        let parameters: Parameters = ["name": name]
        let request = ProjectsColumnsRouter(user: user,
                                            password: password,
                                            action: .updateProjectColumn(id: id, params: parameters))
        Alamofire.request(request)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                completion(try? JSONDecoder().decode(ProjectColumn.self, from: data))
        }
    }
    
    public func deleteProjectColumn(
        id: Int,
        completion: @escaping (Bool) -> Void)
    {
        let request = ProjectsColumnsRouter(user: user,
                                            password: password,
                                            action: .deleteProjectColumn(id: id))
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
    
    public func moveProjectColumn(
        id: Int,
        position: ColumnPosition,
        columnId: Int? = nil,
        completion: @escaping (Bool) -> Void)
    {
        var parameters: Parameters = ["position": position.stringValue]
        if let columnId = columnId {
            parameters["column_id"] = columnId
        }
        let request = ProjectsColumnsRouter(user: user,
                                            password: password,
                                            action: .moveProjectColumn(id: id, params: parameters))
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
    
    public enum ColumnPosition {
        case first, last
        case after(Int)
        
        var stringValue: String {
            switch self {
            case .first:
                return "first"
            case .last:
                return "last"
            case .after(let id):
                return "after:\(id)"
            }
        }
    }
}
