//
//  ProfilePresenter.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import Foundation

class ProfilePresenter {
    let admin = Admin(name: "OOO \"AAA\"", rating: 4.5, reviews: "1004 отзыва", phoneNumber: "89600512177", balance: 666456)
    let user = User(name: "Эвелина", surname: "Меметова", email: "memetova010@mail.ru", balance: 6544, phoneNumber: "89600512177")
    private let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}
