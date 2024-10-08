//
//  LoginByPhoneOrCodeCoordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit

class LoginByPhoneOrCodeCoordinator: BaseCoordinator {
    
    private var hasCode: Bool
    
    
    init(navigationController: UINavigationController, hasCode: Bool) {
        self.hasCode = hasCode
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let firstLoginViewModel = CodeOrNumberViewModel(loadCodeOrPhone: hasCode)
        let loginByPhoneVC = CodeOrNumberView(viewModel: firstLoginViewModel)
        firstLoginViewModel.registrationClosure = { [weak self] in
            self?.showRegisterScreen(isRegistration: true)
        }
        firstLoginViewModel.loginClossure = { [weak self] flag in
            if flag {
                self?.showEnterCodeScreen()
            } else {
                self?.loginWithPhone(isRegistration: false)
            }
        }
        navigationController.pushViewController(loginByPhoneVC, animated: true)
    }
    
    private func showEnterCodeScreen() {
        let registerCodeCoordinator = RegisterCodeCoordinator(navigationController: navigationController)
        addChildCoordinator(registerCodeCoordinator)
        registerCodeCoordinator.start()
    }
    
    private func showRegisterScreen(isRegistration: Bool) {
        let registerCoordinator = LoginOrRegistrationCoordinator(navigationController: navigationController, isRegister: isRegistration)
        addChildCoordinator(registerCoordinator)
        registerCoordinator.start()
        
    }
    
    private func loginWithPhone(isRegistration: Bool) {
        let registerCoordinator = LoginOrRegistrationCoordinator(navigationController: navigationController, isRegister: isRegistration)
        addChildCoordinator(registerCoordinator)
        registerCoordinator.start()
    }
}
