//
//  ResendCodeCoordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//


class ResendCodeCoordinator: BaseCoordinator {
    override func start() {
        let resendCodeVC = ErrorPhoneCodeView()
//        resendCodeVC.onResend = {
//            // Логика для запроса повторного кода
//        }
        navigationController.pushViewController(resendCodeVC, animated: true)
    }
}
