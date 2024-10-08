//
//  FirstLoginViewModel.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import Foundation

class CodeOrNumberViewModel {
    
    var registrationClosure: (() -> Void)?
    var loginClossure: ((Bool) -> Void)?
    var loadCodeOrPhone: Bool
    
    init(loadCodeOrPhone: Bool) {
        self.loadCodeOrPhone = loadCodeOrPhone
    }
    
    func loginButtonTapped() {
        loginClossure?(loadCodeOrPhone)
    }
    
    func registrationButtonTapped() {
        registrationClosure?()
    }
}
