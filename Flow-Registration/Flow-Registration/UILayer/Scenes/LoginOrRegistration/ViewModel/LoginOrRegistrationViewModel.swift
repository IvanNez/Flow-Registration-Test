//
//  LoginOrRegistrationView.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import Foundation
import Combine

class LoginOrRegistrationViewModel {
    
    var getCode: ((String) -> Void)?
    var loginOrRegistration: Bool
    var isLoadingSubject = PassthroughSubject<Bool, Never>()
    
    init(loginOrRegistrationClosure: Bool) {
        self.loginOrRegistration = loginOrRegistrationClosure
    }
    
    func getCodeButtonTapped(number: String) {
        NetworkManager.shared.requestCode(for: number) { [weak self] code in
            self?.isLoadingSubject.send(false)
            self?.getCode?(code)
        }
    }
}
