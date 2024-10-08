//
//  FDButtonColorScenes.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import UIKit

enum FDButtonColorScenes {
    case gradient
    case gray
}

class FDButton: UIView {
    
    private lazy var  button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    private var gradientLayer: CAGradientLayer?
    var action: (() -> Void)?
    var scheme: FDButtonColorScenes = .gradient {
        didSet {
            setColorScheme(scheme: scheme)
        }
    }
    
    init(scheme: FDButtonColorScenes = .gradient) {
        super.init(frame: .zero)
        self.scheme = scheme
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer = gradientLayer {
            gradientLayer.frame = button.bounds
        }
    }
    
    private func setupLayout() {
        setupButton()
    }
    
    private func setupButton() {
        self.addSubview(button)
     
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
       
        setColorScheme(scheme: scheme)
    }
    
    func setTitle(_ title: String?) {
        button.setTitle(title, for: .normal)
    }
    
    func setEnable(_ enable: Bool) {
        button.isEnabled = enable
    }
    
    private func applyGradient() {
       
        gradientLayer?.removeFromSuperlayer()
        
        
        let newGradientLayer = CAGradientLayer()
        newGradientLayer.frame = button.bounds
        newGradientLayer.colors = [
            UIColor(hexString: "#9358F7")!.cgColor,
            UIColor(hexString: "#7B78F2")!.cgColor,
            UIColor(hexString: "#6197EE")!.cgColor,
            UIColor(hexString: "#45B5E9")!.cgColor,
            UIColor(hexString: "#10D7E2")!.cgColor
        ]
        
        newGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        newGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        button.layer.insertSublayer(newGradientLayer, at: 0)
        
        gradientLayer = newGradientLayer
    }
    
    private func applyGray() {
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
        
        button.backgroundColor = .gray
    }
    
    private func setColorScheme(scheme: FDButtonColorScenes) {
        switch scheme {
        case .gradient:
            applyGradient()
        case .gray:
            applyGray()
        }
    }
    
    @objc private func buttonPressed() {
        action?()
    }
}
