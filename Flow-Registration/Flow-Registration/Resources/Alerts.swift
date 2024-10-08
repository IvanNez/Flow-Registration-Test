//
//  Alerts.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 03.10.2024.
//

import UIKit

class Alerts {
    
    static let shared = Alerts()
    
    private init() {}
    
    func alert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert
    }
    
}
