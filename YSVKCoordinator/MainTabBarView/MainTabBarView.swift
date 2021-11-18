//
//  TabView.swift
//  YSVKSwiftUI
//
//  Created by Ярослав on 29.10.2021.
//

import SwiftUI

struct MainTabBarView: View {
    var viewModel: LoginViewModel

    
    var body: some View {
        TabView {
            FriendsView(viewModel: FriendViewModel(FriendAPI(viewModel: viewModel)))
                .navigationBarTitle("", displayMode: .inline)
                .tabItem {
                    Image(systemName: "person.2.circle")
                    Text("Друзья")
                }


            GroupsView(viewModel: GroupViewModel(GroupAPI(viewModel: viewModel)))
                .navigationBarTitle("", displayMode: .inline)
                .tabItem {
                    Image(systemName: "person.3.sequence.fill")
                    Text("Группы")
                }
        }.navigationBarBackButtonHidden(true)
    }
}
