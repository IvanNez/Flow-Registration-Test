//
//  AppCoordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    private var hasCode: Bool
    
    init(navigationController: UINavigationController, hasCode: Bool) {
        self.hasCode = hasCode
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showLoginScreen()
    }
    
    private func showLoginScreen() {
        let loginCoordinator = LoginByPhoneOrCodeCoordinator(navigationController: navigationController, hasCode: hasCode)
        addChildCoordinator(loginCoordinator)
        loginCoordinator.start()
    }
}
