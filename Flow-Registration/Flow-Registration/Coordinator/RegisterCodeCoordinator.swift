//
//  RegisterCodeCoordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//


class RegisterCodeCoordinator: BaseCoordinator {
    override func start() {
      //  let registerVC = LoginOrRegistrationView()
//        registerVC.onGetCode = { [weak self] in
//            self?.showEnterCodeScreen(isForLogin: false)
//        }
     //   navigationController.pushViewController(registerVC, animated: true)
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
}
