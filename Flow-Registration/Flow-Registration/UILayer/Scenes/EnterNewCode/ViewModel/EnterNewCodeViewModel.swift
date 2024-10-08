//
//  EnterNewCodeViewModel.swift
//  Flow-Registration
//
//  Created by Иван Незговоров on 03.10.2024.
//

class EnterNewCodeViewModel {
    var points: [Bool] = [false, false, false, false] // false - белый, true - красный
    var numbers: [String] = [] // Хранение введенных цифр
    
    func togglePoint(at index: Int) {
        if index < points.count {
            points[index].toggle()
        }
    }
    
    func resetPoints() {
        points = [false, false, false, false]
        numbers.removeAll() // Очищаем хранилище цифр
    }
    
    func updatePoints(with input: String) {
        // Обновление состояния точек на основе введенного текста
        points = points.enumerated().map { (index, _) in
            return input.count > index && input[input.index(input.startIndex, offsetBy: index)] == "1" // Проверяем введенный символ
        }
        
        // Сохраняем введенные цифры
        numbers = Array(input).map { String($0) }
    }
}
