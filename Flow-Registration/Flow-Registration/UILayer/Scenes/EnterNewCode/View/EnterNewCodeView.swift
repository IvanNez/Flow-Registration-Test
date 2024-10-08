//
//  EnterNewCodeView.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 03.10.2024.
//

import UIKit

class EnterNewCodeView: UIViewController, UITextFieldDelegate {
    
    // Properties
    private let viewModel: EnterNewCodeViewModel
    
    // UI
    private let roundedView = UIView()
      private let hiddenTextField = UITextField() // Скрытое текстовое поле
      private var pointViews: [UIView] = []
      
      override func viewDidLoad() {
          super.viewDidLoad()
          setupView()
          setupPoints()
          
          // Устанавливаем делегат для скрытого текстового поля
          hiddenTextField.delegate = self
          // Прячем текстовое поле
          hiddenTextField.isHidden = true
          view.addSubview(hiddenTextField)
      }
      
      init(viewModel: EnterNewCodeViewModel) {
          self.viewModel = viewModel
          super.init(nibName: nil, bundle: nil)
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      private func setupView() {
          view.backgroundColor = .white
          
          // Настройка roundedView
          roundedView.backgroundColor = .lightGray
          roundedView.layer.cornerRadius = 20
          roundedView.translatesAutoresizingMaskIntoConstraints = false
          
          // Добавление roundedView на экран
          view.addSubview(roundedView)
          
          // Установка автолэйаута для roundedView
          NSLayoutConstraint.activate([
              roundedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              roundedView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              roundedView.widthAnchor.constraint(equalToConstant: 300),
              roundedView.heightAnchor.constraint(equalToConstant: 200)
          ])
          
          // Добавление жеста для открытия клавиатуры
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRoundedView))
          roundedView.addGestureRecognizer(tapGesture)
      }
      
      private func setupPoints() {
          let pointSize: CGFloat = 20
          let spacing: CGFloat = 30
          
          for i in 0..<4 {
              let pointView = UIView()
              pointView.layer.cornerRadius = pointSize / 2
              pointView.backgroundColor = .white
              pointView.translatesAutoresizingMaskIntoConstraints = false
              
              roundedView.addSubview(pointView)
              pointViews.append(pointView)
              
              // Установка автолэйаута для точек
              NSLayoutConstraint.activate([
                  pointView.widthAnchor.constraint(equalToConstant: pointSize),
                  pointView.heightAnchor.constraint(equalToConstant: pointSize),
                  pointView.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 20),
                  pointView.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: CGFloat(i) * spacing + 20)
              ])
          }
      }
      
      @objc private func didTapRoundedView() {
          hiddenTextField.becomeFirstResponder()
      }
      
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let currentText = textField.text ?? ""
          let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
          
          // Обновляем точки на основе введенного текста
          viewModel.updatePoints(with: updatedText)
          
          // Обновление цвета точек
          for i in 0..<pointViews.count {
              pointViews[i].backgroundColor = viewModel.points[i] ? .red : .white
          }
          
          return true
      }
      
      func textFieldDidEndEditing(_ textField: UITextField) {
          // Сброс точек, если текстовое поле пустое
          if textField.text?.isEmpty ?? true {
              viewModel.resetPoints()
              for pointView in pointViews {
                  pointView.backgroundColor = .white
              }
          }
      }
  }
