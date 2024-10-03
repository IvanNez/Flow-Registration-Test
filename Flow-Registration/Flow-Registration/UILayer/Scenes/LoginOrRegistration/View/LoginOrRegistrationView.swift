//
//  LoginOrRegistrationView.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit
import Combine

class LoginOrRegistrationView: UIViewController {
    
    // Properties
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: LoginOrRegistrationViewModel
    
    // UI
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        indicator.isHidden = true
        return indicator
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 53
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var firstVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    private lazy var subTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Номер телефона"
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 52
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var numberLBL: UILabel = {
        let lbl = UILabel()
        lbl.text = "+7"
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private lazy var tfNumber = FDViewGradient(frame: .zero, leftPadding: 34, cornerRadius: 10, isCode: false)
    private lazy var secondVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 22
        return stackView
    }()
    private lazy var helperLBL: UILabel = {
        let lbl = UILabel()
        lbl.text = "Код прийдет на ваш номер"
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    private let getCodeButton = FDButton(scheme: .gradient)
    
    init(viewModel: LoginOrRegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        sinkCode()
    }
}

// MARK: -- Setup layer
private extension  LoginOrRegistrationView {
    func setup() {
        title = viewModel.loginOrRegistration ? "Войти" : "Зарегестрироваться"
        view.backgroundColor = .black
        setupComponents()
        setupButtonAndActivityIndicator()
    }
    
    func setupComponents() {
        firstVStackView.addArrangedSubview(subTitle)
        hStackView.addArrangedSubview(numberLBL)
        hStackView.addArrangedSubview(tfNumber)
        firstVStackView.addArrangedSubview(hStackView)
        secondVStackView.addArrangedSubview(firstVStackView)
        secondVStackView.addArrangedSubview(helperLBL)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(firstVStackView)
        mainStackView.addArrangedSubview(secondVStackView)
        mainStackView.addArrangedSubview(getCodeButton)
        
        tfNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 33),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            tfNumber.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupButtonAndActivityIndicator() {
        view.addSubview(activityIndicator)
        
        getCodeButton.setTitle(viewModel.loginOrRegistration ? "Регистрация": "Войти")
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            getCodeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        getCodeButton.action = { [weak self] in
            guard let number = self?.tfNumber.text else { return }
            self?.activityIndicator.startAnimating()
            self?.activityIndicator.isHidden = false
            self?.view.isUserInteractionEnabled = false
            self?.viewModel.getCodeButtonTapped(number: number)
            
        }
    }
}

// MARK: -- Sink
private extension LoginOrRegistrationView {
    func sinkCode() {
        viewModel.isLoadingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    self?.activityIndicator.isHidden = false
                    self?.view.isUserInteractionEnabled = false // Отключаем взаимодействие
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.view.isUserInteractionEnabled = true // Включаем взаимодействие
                }
            }
            .store(in: &cancellables)
    }
}
