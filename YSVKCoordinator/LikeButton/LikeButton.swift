//
//  LikeButton.swift
//  YSVKSwiftUI
//
//  Created by Ярослав on 11.11.2021.
//

import Foundation
import SwiftUI

struct LikeButton : View {
    @State private var isLiked = false
    @State private var likesCount: Int = Int.random(in: 9...999)
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "heart.fill")
                    .opacity(isLiked ? 1 : 0)
                    .scaleEffect(isLiked ? 1.0 : 0.0)
                    .animation(.easeIn(duration: 0.15))
                Image(systemName: "heart")
            }.foregroundColor(isLiked ? .red : .white)
            
            Text("\(likesCount)")
                .transition(.opacity.animation(.easeInOut(duration: 0.35)))
                .id(UUID())
        }
        .font(.system(size: 48))
        .onTapGesture {
            isLiked.toggle()
            likesCount += isLiked ? 1 : -1
        }
    }
}
