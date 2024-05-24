//
//  AuthPresenter.swift
//  store
//
//  Created by Evelina on 01.07.2023.
//

import Foundation

//protocol AuthPresenterProtocol {
//    func saveToken(token: String, emailOrPhoneNumber: String) -> Bool
//    func getToken(emailOrPhoneNumber: String) -> String?
//}

class AuthPresenter {
    private let keychainService: KeychainServiceProtocol
    private let networkManager: NetworkManagerProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    let validator: TextValidatorProtocol
    var didTapToOpenRegistrationScreen: (() -> Void)?
    var didTapToOpenAutorizationScreen: (() -> Void)?
    var didTapToRegister: (() -> Void)?
    init(keychainService: KeychainServiceProtocol,
         validator: TextValidatorProtocol,
         networkManager: NetworkManagerProtocol,
         userDefaultsManager: UserDefaultsManagerProtocol
    ) {
        self.keychainService = keychainService
        self.validator = validator
        self.networkManager = networkManager
        self.userDefaultsManager = userDefaultsManager
    }
    func saveToken(token: String, emailOrPhoneNumber: String) -> Bool {
        guard let tokenData: Data = token.data(using: .utf8) else {return false}
        return keychainService.setValue(service: "SkoroHod",
                                        account: emailOrPhoneNumber,
                                        value: tokenData)
    }
    func getToken(emailOrPhoneNumber: String) -> String? {
        guard let data = keychainService.getValue(service: "SkoroHod",
                                                  account: emailOrPhoneNumber) else {return nil}
        let token = String(decoding: data, as: UTF8.self)
        return token
    }
}
extension AuthPresenter: StartViewOutput {
    func viewDidTapToRegistrationScreen() {
        didTapToOpenRegistrationScreen?()
    }
    func viewDidTapToAutorizationScreen() {
        didTapToOpenAutorizationScreen?()
    }
}
extension AuthPresenter: RegistrationViewOutput {
    func viewDidTapToRegister(login: String, password: String, role: String) {
        userDefaultsManager.setUserRole(role: UserRole(rawValue: role) ?? .user)
        networkManager.registerUser(login: login, password: password, role: role) { result in
            switch result {
            case .success(_):
                self.didTapToRegister?()
                self.userDefaultsManager.setUserRole(role: UserRole(rawValue: role) ?? .user)
            case .failure(_):
                break
            }
        }
    }
}
