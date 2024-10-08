//
//  FDViewGradient.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit


class FDViewGradient: UIView {
    
    let tf = UITextField()
    private var gradientLayer: CAGradientLayer?
    var nextTextField: UITextField?
    var previousTextField: UITextField?
    var isCode: Bool
    var textClosure: ((String) -> Void)?
    var text: String? {
        get {
            return tf.text
        }
        set {
            tf.text = newValue
        }
    }
    
    init(frame: CGRect, leftPadding: CGFloat? = nil, cornerRadius: CGFloat = 10.0, isCode: Bool) {
        self.isCode = isCode
        super.init(frame: frame)
        setupLayout(leftPadding: leftPadding)
        setupGradientBorder(cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
        
    }
}

// MARK: -- Setup layer
private extension FDViewGradient {
    func setupGradientBorder(cornerRadius: CGFloat) {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor(hexString: "#9358F7")!.cgColor,
            UIColor(hexString: "#7B78F2")!.cgColor,
            UIColor(hexString: "#6197EE")!.cgColor,
            UIColor(hexString: "#45B5E9")!.cgColor,
            UIColor(hexString: "#10D7E2")!.cgColor
        ]
        gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer?.frame = bounds

        layer.insertSublayer(gradientLayer!, at: 0)
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func setupLayout(leftPadding: CGFloat?) {
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.clear
        tf.borderStyle = .none
        tf.textColor = .white
        tf.keyboardType = .numberPad
        tf.delegate = self
        tf.font = UIFont.systemFont(ofSize: 16)
        addSubview(tf)
        
        if let padding = leftPadding {
            tf.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        } else {
            tf.textAlignment = .center
            tf.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            tf.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tf.topAnchor.constraint(equalTo: self.topAnchor),
            tf.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    
}

// MARK: -- TF DELEGATE
extension FDViewGradient: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if string.isEmpty {
            
            textClosure?(string)
            handleSymbolRemoved()
        } else {
            handleSymbolEntered(updatedText)
        }
        
        if isCode {
            return updatedText.count <= 1
        } else {
            return true
        }
    }
    
    private func handleSymbolEntered(_ updatedText: String) {
        if let text = updatedText.last.map(String.init) {
            textClosure?(text)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.moveToNextTextField()
        }
    }
    
    private func handleSymbolRemoved() {
        
        DispatchQueue.main.async { [weak self] in
            self?.moveToPreviousTextField()
        }
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 1 {
                moveToNextTextField()
            } else {
                moveToPreviousTextField()
            }
        }
    }
    
    
    
    private func moveToNextTextField() {
        nextTextField?.becomeFirstResponder()
    }
    
    private func moveToPreviousTextField() {
        previousTextField?.becomeFirstResponder()
    }
}
