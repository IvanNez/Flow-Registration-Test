//
//  NetworkManager.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 02.10.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func requestCode(for number: String, completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            sleep(1)
            
            let code = "11111"
            
            DispatchQueue.main.async {
                completion(code)
            }
        }
    }
}
