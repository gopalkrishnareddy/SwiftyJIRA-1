//
//  JIRAStatusesController+StatusCategory.swift
//  SwiftyJIRA
//
//  Created by Joe DeCapo on 11/28/17.
//

import Foundation
import Alamofire

extension JIRAStatusesController {
    
    public func getStatusCategories(
        completion: @escaping ([JIRAStatusCategoryJSONBean]?) -> Void)
    {
        let request = JIRAStatusCategoriesRouter(user: user,
                                                 password: password,
                                                 action: .getStatusCategories)
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode([JIRAStatusCategoryJSONBean].self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
    
    public func getStatusCategory(
        idOrKey: String,
        completion: @escaping (JIRAStatusCategoryJSONBean?) -> Void)
    {
        let request = JIRAStatusCategoriesRouter(user: user,
                                                 password: password,
                                                 action: .getStatusCategory(idOrKey: idOrKey))
        Alamofire.request(request)
            .validate()
            .responseJSON(queue: queue) { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                do {
                    completion(try JSONDecoder().decode(JIRAStatusCategoryJSONBean.self, from: data))
                } catch let error {
                    print(error)
                    completion(nil)
                }
        }
    }
}
