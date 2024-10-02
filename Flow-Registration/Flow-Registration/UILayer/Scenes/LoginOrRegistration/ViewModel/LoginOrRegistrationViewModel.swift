//
//  LoginOrRegistrationView.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import Foundation

class LoginOrRegistrationViewModel {
    
    var getCode: ((String) -> Void)?
    var loginOrRegistrationClosure: Bool
    
    init(loginOrRegistrationClosure: Bool) {
        self.loginOrRegistrationClosure = loginOrRegistrationClosure
    }
    
    func getCodeButtonTapped(number: String) {
        getCode?(number)
    }
}
