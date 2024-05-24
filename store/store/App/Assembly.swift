//
//  Assembly.swift
//  store
//
//  Created by Evelina on 10.07.2023.
//

import Foundation
import Moya
import Alamofire

protocol AssemblyProtocol {
    var keychainService: KeychainServiceProtocol { get }
    var textValidator: TextValidatorProtocol { get }
    var cashingManager: CashingManagerProtocol { get }
    var photoManager: PhotoManagerProtocol { get }
    var balanceConverter: BalanceConverter { get }
    var networkManager: NetworkManagerProtocol { get }
//    var userManager: UserManagerProtocol { get }
//    var cartManager: CartManagerProtocol { get }
    var userDefaultsManager: UserDefaultsManager { get }
}

final class Assembly: AssemblyProtocol {
    lazy var keychainService: KeychainServiceProtocol = KeychainService()
    lazy var textValidator: TextValidatorProtocol = TextValidator()
    lazy var cashingManager: CashingManagerProtocol = CashingManager()
    lazy var photoManager: PhotoManagerProtocol = PhotoManager()
    lazy var balanceConverter: BalanceConverter = BalanceConverter()
    lazy var networkManager: NetworkManagerProtocol = NetworkManager(provider: MoyaProvider<RequestManager>())
    lazy var userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
}
