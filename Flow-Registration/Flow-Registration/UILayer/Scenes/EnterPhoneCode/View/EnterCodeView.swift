//
//  EnterCodeView.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit
import Combine

class EnterCodeView: UIViewController {
    
    // Properties
    private let viewModel: EnterCodeViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    // UI
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 27
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var firstStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 17
        stack.axis = .vertical
        return stack
    }()
    private lazy var secondStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 35
        stack.axis = .vertical
        return stack
    }()
    private lazy var thirdStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 51
        return stack
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    private lazy var mainTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Верификация"
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var subTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Введите код из смс,\n что мы отправили вам"
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    private lazy var timeLBL: UILabel = {
        let lbl = UILabel()
        lbl.text = "Запросить код можно \n через 05:00"
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    private lazy var buttonTap = FDButton(scheme: .gray)
    
    init(viewModel: EnterCodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
}

// MARK: -- Setup layer
private extension EnterCodeView {
    func setup() {
        view.backgroundColor = .black
        title = viewModel.loginOrRegistration ? "Войти" : "Зарегестрироваться"
        setupComponents()
        setupButton()
    }
    
    func setupComponents() {
        var cell: [FDViewGradient] = []
        for _ in 0..<6  {
            let view = FDViewGradient(frame: .zero, leftPadding: nil, cornerRadius: 3, isCode: true)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textClosure = { [weak self] char in
                self?.viewModel.setCode(code: char)
            }
            cell.append(view)
            hStack.addArrangedSubview(view)
        }
        cell.enumerated().forEach { index, currentView in
            if index < cell.count - 1 {
                currentView.nextTextField = cell[index + 1].tf
            }
            if index > 0 {
                currentView.previousTextField = cell[index - 1].tf
            }
        }
        
        firstStack.addArrangedSubview(mainTitle)
        firstStack.addArrangedSubview(subTitle)
        secondStack.addArrangedSubview(firstStack)
        secondStack.addArrangedSubview(timeLBL)
        thirdStack.addArrangedSubview(secondStack)
        thirdStack.addArrangedSubview(hStack)
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(thirdStack)
        mainStack.addArrangedSubview(buttonTap)
        
        buttonTap.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 66),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            hStack.heightAnchor.constraint(equalToConstant: 46),
            
            buttonTap.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupButton() {
        buttonTap.setTitle(viewModel.loginOrRegistration ? "Зарегестрироваться" : "Войти")
        buttonTap.action = { [weak self] in
            let alert = Alerts.shared.alert(title: "Добро пожаловать", message: "Вы успешно \(self!.viewModel.loginOrRegistration ? "зарегестрировались" : "вошли")")
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: { [weak self] _ in
                self?.viewModel.checkCode()
            }))
            self?.present(alert, animated: true)
        }
        buttonTap.setEnable(false)
    }
}

// MARK: -- Binding
private extension EnterCodeView {
    private func bindViewModel() {
        viewModel.$inputCode
            .sink { [weak self] code in
                self?.updateButtonState(code: code)
            }
            .store(in: &cancellables)
    }
    
    private func updateButtonState(code: String) {
        if code.count == 6 {
            buttonTap.scheme = .gradient
            buttonTap.setEnable(true)
        } else {
            buttonTap.scheme = .gray
            buttonTap.setEnable(false)
        }
    }
}
