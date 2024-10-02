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
        let viewModel = LoginOrRegistrationViewModel(loginOrRegistrationClosure: isRegister)
        let view = LoginOrRegistrationView(viewModel: viewModel)
        viewModel.getCode = { [weak self] code in
            self?.setCodeScreen(code)
        }
        navigationController.pushViewController(view, animated: true)
    }
    
    private func setCodeScreen(_ code: String) {
        let viewModel = EnterCodeViewModel(loginOrRegistrationClosure: isRegister, code: code)
        let view = EnterCodeView(viewModel: viewModel)
        navigationController.pushViewController(view, animated: true)
    }
}
