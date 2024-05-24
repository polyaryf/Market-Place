//
//  UserManager.swift
//  store
//
//  Created by Evelina on 10.07.2023.
//

import Foundation

enum UserRole: String {
    case user = "customer"
    case admin = "admin"
}

protocol UserManagerProtocol {
    var userRole: UserRole { get }
    var isAutorize: Bool { get }
}

class UserManager: UserManagerProtocol {
    var userRole: UserRole
    var isAutorize: Bool
    
    init(userRole: UserRole, isAutorize: Bool) {
        self.userRole = userRole
        self.isAutorize = isAutorize
    }
}
