//
//  EnterCodeViewModel.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import Foundation

class EnterCodeViewModel {
    
    var code: String
    var inputCode: String = ""
    
    var loginOrRegistration: Bool
    
    init(loginOrRegistrationClosure: Bool, code: String) {
        self.loginOrRegistration = loginOrRegistrationClosure
        self.code = code
    }
    
    func setCode(code: String) {
        if !code.isEmpty {
               inputCode.append(code)
           } else {
               // Если код пустой, значит символ удалён, удаляем последний символ из inputCode
               if !inputCode.isEmpty {
                   inputCode.removeLast()
               }
           }
        print(inputCode)
    }
}
