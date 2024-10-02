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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {}
}
