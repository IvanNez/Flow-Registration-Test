//
//  LoginOrRegistrationCoordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//
import UIKit

class LoginOrRegistrationCoordinator: BaseCoordinator {
    
    var isRegister: Bool
    
    init(navigationController: UINavigationController, isRegister: Bool) {
        self.isRegister = isRegister
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let viewModel = LoginOrRegistrationViewModel()
        let view = LoginOrRegistrationView(viewModel: viewModel)
        navigationController.pushViewController(view, animated: true)
    }
}
