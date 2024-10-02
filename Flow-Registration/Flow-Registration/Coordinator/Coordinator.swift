//
//  Coordinator.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//


import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    
}

class BaseCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
  
    func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }

    func addChildCoordinator(_ child: Coordinator) {
        childCoordinators.append(child)
    }
}
