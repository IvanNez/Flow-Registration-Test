//
//  LoginOrRegistrationView.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit

class LoginOrRegistrationView: UIViewController {
    
    // Properties
    private let viewModel: LoginOrRegistrationViewModel
    
    // UI

    init(viewModel: LoginOrRegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login or Registration"
    }
}

// MARK: -- Setup layer
