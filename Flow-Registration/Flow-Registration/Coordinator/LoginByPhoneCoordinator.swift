//
//  LoginByPhoneCoordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit

class LoginByPhoneCoordinator: BaseCoordinator {
    override func start() {
        let loginByPhoneVC = FirstLoginView()
//        loginByPhoneVC.onGetCode = { [weak self] in
//            self?.showEnterCodeScreen(isForLogin: true)
//        }
//        loginByPhoneVC.onRegister = { [weak self] in
//            self?.showRegisterScreen()
//        }
        navigationController.pushViewController(loginByPhoneVC, animated: true)
    }
    
    private func showEnterCodeScreen(isForLogin: Bool) {
        let enterCodeVC = EnterCodeView()
//        enterCodeVC.onSubmitCode = {
//            let alert = UIAlertController(title: "Готово", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.navigationController.present(alert, animated: true)
//        }
        navigationController.pushViewController(enterCodeVC, animated: true)
    }
    
    private func showRegisterScreen() {
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
        registerCoordinator.start()
    }
}
