//
//  LoginByCodeCoordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//


class LoginByCodeCoordinator: BaseCoordinator {
    override func start() {
        let loginByCodeVC = CodeLoginView()
//        loginByCodeVC.onSkip = {
//            // Логика для пропуска
//        }
        navigationController.pushViewController(loginByCodeVC, animated: true)
    }
}
