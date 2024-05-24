//
//  TextValidator.swift
//  store
//
//  Created by Evelina on 02.07.2023.
//

import Foundation

protocol TextValidatorProtocol {
    func validateEmail(email: String) -> Bool
    func validatePhoneNumber(number: String) -> Bool
    func validatePassword(password: String) -> Bool
    func validatePrice(from: Int, to: Int) -> Bool
}

class TextValidator: TextValidatorProtocol {
    func validateEmail(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        do {
            let regex = try NSRegularExpression(pattern: "\\b[A-Za-z0-9]+@[a-z]+\\.[a-z]{2,}\\b")
            let matches = regex.matches(in: email, range: range)
            if matches.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    func validatePhoneNumber(number: String) -> Bool {
        let range = NSRange(location: 0, length: number.utf16.count)
        do {
            let regex = try NSRegularExpression(pattern: "(\\+79|89)[0-9]{9}")
            let matches = regex.matches(in: number, range: range)
            if matches.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    func validatePassword(password: String) -> Bool {
        let range = NSRange(location: 0, length: password.utf16.count)
        do {
            let regex = try NSRegularExpression(pattern: "[a-zA-Z0-9]{8,16}")
            let matches = regex.matches(in: password, range: range)
            if matches.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    func validatePrice(from: Int, to: Int) -> Bool {
        if to >= from && from > 0 && to > 0 {
            return true
        }
        return false
    }
}
