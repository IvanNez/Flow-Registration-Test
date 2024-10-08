//
//  RegisterCodeCoordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//


class RegisterCodeCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = EnterNewCodeViewModel()
        let view = EnterNewCodeView(viewModel: viewModel)
        navigationController.pushViewController(view, animated: true)
    }
}
