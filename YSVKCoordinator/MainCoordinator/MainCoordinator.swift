//
//  MainCoordinator.swift
//  YSVKCoordinator
//
//  Created by Ярослав on 16.11.2021.
//

import UIKit
import SwiftUI
import Combine

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start ()
}

class MainCoordinator: Coordinator {
    private let loginViewModel: LoginViewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        loginViewModel.$isAuthorized.subscribe(on: RunLoop.main).sink { [weak self] isAuthorized in
            guard let self = self else { return }
            if !isAuthorized {
                self.navigationController.popToRootViewController(animated: true)
            } else {
                let mainTabBarView = self.createMainTabBarController()
                self.navigationController.pushViewController(mainTabBarView, animated: true)
            }
            
        }.store(in: &cancellables)
    }
    
    private func createMainTabBarController() -> UIViewController {
        let mainTabBarView = MainTabBarView()
        return UIHostingController(rootView: mainTabBarView)
    }
}
