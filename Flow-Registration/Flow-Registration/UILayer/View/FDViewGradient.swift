//
//  FDViewGradient.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit


class FDViewGradient: UIView {
    
    private let tf = UITextField()
    private var gradientLayer: CAGradientLayer?
    var text: String? {
        get {
            return tf.text
        }
        set {
            tf.text = newValue
        }
    }
    
    init(frame: CGRect, leftPadding: CGFloat? = nil, cornerRadius: CGFloat = 10.0) {
        super.init(frame: frame)
        setupLayout(leftPadding: leftPadding)
        setupGradientBorder(cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(leftPadding: CGFloat?) {
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.clear
        tf.borderStyle = .none
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16) // test
        addSubview(tf)
        
        print(leftPadding)
        if let padding = leftPadding {
            NSLayoutConstraint.activate([
                tf.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                tf.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                tf.topAnchor.constraint(equalTo: self.topAnchor),
                tf.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                tf.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                tf.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
    }
    
    private func setupGradientBorder(cornerRadius: CGFloat) {
        
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor(hexString: "#9358F7")!.cgColor,
            UIColor(hexString: "#7B78F2")!.cgColor,
            UIColor(hexString: "#6197EE")!.cgColor,
            UIColor(hexString: "#45B5E9")!.cgColor,
            UIColor(hexString: "#10D7E2")!.cgColor
        ]
        gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0) // верх
               gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1) // низ
               gradientLayer?.frame = bounds
               
               // Обеспечиваем добавление градиентного слоя в качестве бордера
               layer.insertSublayer(gradientLayer!, at: 0) // добавляем градиент в слой
               layer.cornerRadius = cornerRadius // радиус углов устанавливаем через параметр
               layer.masksToBounds = true 
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
               if let borderLayer = gradientLayer?.mask as? CAShapeLayer {
                   borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
               }
    }
}
