//
//  FriendsView.swift
//  YSVKSwiftUI
//
//  Created by Ярослав on 29.10.2021.
//

import SwiftUI

struct FriendsView: View {
    @ObservedObject var viewModel: FriendViewModel
    
    init(viewModel: FriendViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.friends) { friend in
            NavigationLink(destination: FriendPageView(friend: friend)) {
                FriendRowView(friend: friend)
            }
        }
        .modifier(PlainList())
        .onAppear { viewModel.fetch() }
    }
}
