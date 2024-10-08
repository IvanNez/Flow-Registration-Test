//
//  EnterCodeViewModel.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import Foundation

class EnterCodeViewModel {
    
    var codeApprove: String
    @Published var inputCode: String = ""
    var dissmis: (() -> Void)?
    
    var loginOrRegistration: Bool
    
    init(loginOrRegistrationClosure: Bool, code: String) {
        self.loginOrRegistration = loginOrRegistrationClosure
        self.codeApprove = code
    }
    
    func setCode(code: String) {
        if inputCode.count < 6 {
            if !code.isEmpty {
                   inputCode.append(code)
               } else {
                   if !inputCode.isEmpty {
                       inputCode.removeLast()
                   }
               }
        } else {
            if code.isEmpty {
                inputCode.removeLast()
            }
        }
    }
    
    func checkCode() {
        if inputCode.count == 6 && inputCode == codeApprove {
            dissmis?()
        }
    }
}
