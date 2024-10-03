//
//  FirstLoginView.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit

class CodeOrNumberView: UIViewController {
    
    // Properties
    private var viewModel: CodeOrNumberViewModel
    
    // UI
    private lazy var vStackMain: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 100
        return stack
    }()
    private lazy var vStackFirst: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 30
        return stack
    }()
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .icon)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var vStackSecond: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 17
        return stack
    }()
    private lazy var nameAPPLBL: UILabel = {
        let lbl = UILabel()
        lbl.text = "SIS"
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var subTitleLBL: UILabel = {
        let lbl = UILabel()
        lbl.text = "Выберите свою безопасность"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let loginButton = FDButton(scheme: .gradient)
    private lazy var vStackThird: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var dontHaveAccountLBL: UILabel = {
        let lbl = UILabel()
        lbl.text = "У вас нет аккаунта?"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегестрируйтесь сейчас", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToRegistrationPage), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: CodeOrNumberViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: -- Setup layer
private extension CodeOrNumberView {
    func setup() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        setupComponents()
        setupButton()
    }
    func setupComponents() {
        view.addSubview(vStackMain)
        vStackFirst.addArrangedSubview(iconImage)
        vStackSecond.addArrangedSubview(nameAPPLBL)
        vStackSecond.addArrangedSubview(subTitleLBL)
        vStackFirst.addArrangedSubview(vStackSecond)
        vStackMain.addArrangedSubview(vStackFirst)
        vStackMain.addArrangedSubview(loginButton)
        vStackThird.addArrangedSubview(dontHaveAccountLBL)
        vStackThird.addArrangedSubview(registrationButton)
        vStackMain.addArrangedSubview(vStackThird)
        
        NSLayoutConstraint.activate([
            vStackMain.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -89),
            vStackMain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            vStackMain.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            iconImage.heightAnchor.constraint(equalToConstant: 79),
            loginButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func setupButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle(viewModel.loadCodeOrPhone ? "Войти по код приложению": "Войти по номер телефона")
        loginButton.action = { [weak self] in
            self?.viewModel.loginButtonTapped()
        }
    }
}


// MARK: -- OBJC
extension CodeOrNumberView {
    @objc func goToRegistrationPage() {
        viewModel.registrationButtonTapped()
    }
}
