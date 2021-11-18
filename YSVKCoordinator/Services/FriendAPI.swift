//
//  FriendsAPI.swift
//  YSVKSwiftUI
//
//  Created by Ярослав on 06.11.2021.
//

import SwiftUI
import Alamofire

protocol FriendService {
    func get (_ completion: @escaping (Friends?) -> ())
}

class FriendAPI: FriendService {
    @ObservedObject var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    let baseUrl = "https://api.vk.com/method"
    var params: Parameters = [:]
    var request: String?
    
    func get(_ completion: @escaping (Friends?) -> ()) {
        let method = "/friends.get"
        let url = baseUrl + method
        
        self.params = [
            "client_id": viewModel.cliendId,
            "user_id": viewModel.userId,
            "access_token": viewModel.token,
            "v": viewModel.version,
        ]
        
        params["extended"] = "1"
        params["fields"] = "photo_100,online,sex,last_seen"
        
        AF.request(url, method: .get, parameters: params).responseData{ response in
            self.request = response.request?.description
            
            guard let data = response.data else { return }
            
            do {
                var friends: Friends
                friends = try JSONDecoder().decode(Friends.self, from: data)
                completion(friends)
            } catch {
                print(error)
            }
        }
    }
}
