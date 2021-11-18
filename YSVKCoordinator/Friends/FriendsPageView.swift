//
//  FriendPageView.swift
//  YSVKSwiftUI
//
//  Created by Ярослав on 06.11.2021.
//

import SwiftUI
import Kingfisher

struct FriendPageView: View {
    var friend: FriendItem
    var body: some View {
        VStack {
            AvatarImage { KFImage(URL(string: friend.photo100!)!) }
            
            Text("\(friend.firstName) \(friend.lastName)")
                .modifier(TitleText())
            
            Spacer().frame(height: 50.0)
            
            LikeButton()
            
            Spacer()
        }.padding()
    }
}
