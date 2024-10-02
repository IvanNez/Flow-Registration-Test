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
        if hasCode {
            showLoginByCodeScreen()
        } else {
            showLoginByPhoneScreen()
        }
    }
    
    private func showLoginByPhoneScreen() {
        let loginCoordinator = LoginByPhoneCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
    
    private func showLoginByCodeScreen() {
        let loginCoordinator = LoginByCodeCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
}
