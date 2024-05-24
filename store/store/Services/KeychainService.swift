//
//  KeychainService.swift
//  store
//
//  Created by Evelina on 01.07.2023.
//

import Foundation
import Security

protocol KeychainServiceProtocol {
    func setValue(service: String, account: String, value: Data) -> Bool
    func getValue(service: String, account: String) -> Data?
//    func deleteValue(service: String, account: String) -> Bool
}

class KeychainService: KeychainServiceProtocol {
    func setValue(service: String, account: String, value: Data) -> Bool {
        let query: [String: Any] = [
            toString(kSecClass): kSecClassGenericPassword,
            toString(kSecAttrAccount): account,
            toString(kSecAttrService): service,
            toString(kSecValueData): value
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }
    func getValue(service: String, account: String) -> Data? {
        let query: [String: Any] = [
            toString(kSecClass): kSecClassGenericPassword,
            toString(kSecAttrAccount): account,
            toString(kSecAttrService): service,
            toString(kSecReturnData): true
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(
                query as CFDictionary,
                &result
        )
        guard status == noErr, let data = result as? Data else {return nil}
        return data
    }
//    func deleteValue(service: String, account: String) -> Bool {
//        let query: [String: Any] = [
//            toString(kSecClass): kSecClassGenericPassword,
//            toString(kSecAttrAccount): account
////            toString(kSecAttrService): service,
////            toString(kSecValueData): value
//        ]
//        return false
//    }
}

private func toString(_ value: CFString) -> String {
    return value as String
}
