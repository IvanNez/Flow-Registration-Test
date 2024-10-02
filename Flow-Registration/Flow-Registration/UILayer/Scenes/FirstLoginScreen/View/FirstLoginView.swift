//
//  FirstLoginView.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit

class FirstLoginView: UIViewController {
    
    private let loginButton = FDButton(scheme: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "First login"
        setup()
    }
    func setup() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
