//
//  UserDefaultsManager.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func setUserRole(role: UserRole)
    func getUserRole() -> UserRole?
}

class UserDefaultsManager: UserDefaultsManagerProtocol {
    func setUserRole(role: UserRole) {
        UserDefaults.standard.set(role.rawValue, forKey: "userRole")
    }
    func getUserRole() -> UserRole? {
        let role = UserDefaults.standard.string(forKey: "userRole")
        switch role {
        case UserRole.user.rawValue: return .user
        case UserRole.admin.rawValue: return .admin
        case .none:
            return nil
        case .some(let wrapped):
            return nil
        }
    }
}
