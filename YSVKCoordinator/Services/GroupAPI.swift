//
//  GroupAPI.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 13.07.2021.
//

import Alamofire
import SwiftUI

protocol GroupService {
    func get (_ completion: @escaping (Groups?) -> ())
}

class GroupAPI: GroupService {
    @ObservedObject var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    let baseUrl = "https://api.vk.com/method"
    let method = "/groups.get"
    var params: Parameters = [:]
    
    func get(_ completion: @escaping (Groups?) -> ()) {
        self.params = [
            "client_id": viewModel.cliendId,
            "user_id": viewModel.userId,
            "access_token": viewModel.token,
            "v": viewModel.version,
            "extended": "1",
            "fields": "description,members_count",
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: params).responseData { response in
            
            guard let data = response.data else { return }
            
            do {
                var groups: Groups
                groups = try JSONDecoder().decode(Groups.self, from: data)
                completion(groups)
            } catch {
                print(error)
            }
            
        }
    }
}
