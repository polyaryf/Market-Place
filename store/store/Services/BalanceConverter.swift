//
//  BalanceConverter.swift
//  store
//
//  Created by Evelina on 09.07.2023.
//

import Foundation

protocol BalanceConverterProtocol {
    static func convert(balance: Int) -> String
}

class BalanceConverter: BalanceConverterProtocol {
    static func convert(balance: Int) -> String {
        var string = ""
        let digits: [Int] = String(balance).compactMap {Int(String($0))}.reversed()
        for count in 1...digits.count {
            let numberString = String(digits[count - 1])
            string.insert(contentsOf: numberString, at: string.startIndex)
            if count % 3 == 0 {
                string.insert(" ", at: string.startIndex)
            }
        }
        return string
    }
}
