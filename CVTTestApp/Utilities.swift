//
//  Utilities.swift
//  CVTTestApp
//
//  Created by Игорь on 10.05.2021.
//

import Foundation

extension String {
    func isValid() -> Bool {
        let validCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" +
                              "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЮЯабвгдежзийклмнопрстуфхцчшщьюя"
        var result = true

        self.forEach { character in
            if !validCharacters.contains(character) {
                result = false
                return
            }
        }

        return result
    }
}

extension Double {
    func isValid() -> Bool {
        return (0 < self && self < 6 && self.isInteger) ? true : false
    }
}

extension FloatingPoint {
    var isInteger: Bool {
        return floor(self) == self
    }
}
