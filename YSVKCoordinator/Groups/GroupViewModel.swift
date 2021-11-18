//
//  GroupViewModel.swift
//  YSVKSwiftUI
//
//  Created by Ярослав on 05.11.2021.
//

import SwiftUI

class GroupViewModel: ObservableObject {
    @Published var groups: [GroupItem] = []
    let api: GroupService
    
    init(_ api: GroupService) {
        self.api = api
    }
    
    public func fetch() {
        api.get { [weak self] groups in
            guard let self = self else { return }
            self.groups = groups!.response.items
        }
    }
}
