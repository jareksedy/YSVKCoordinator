//
//  Builders.swift
//  YSVKSwiftUI
//
//  Created by Ярослав on 23.10.2021.
//

import SwiftUI
import Kingfisher

struct AvatarImage: View {
    @State private var scaleFactor = 1.0
    var content: KFImage
 
    init(@ViewBuilder content: () -> KFImage) {
        self.content = content()
    }
 
    var body: some View {
        content
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .scaleEffect(scaleFactor)
            .animation(.spring(response: 0.2, dampingFraction: 0.35, blendDuration: 0.25))
            .onTouchGesture(
                touchBegan: { withAnimation { self.scaleFactor = 1.75 } },
                touchEnd: { _ in withAnimation { self.scaleFactor = 1.0 } }
            )
    }
}
