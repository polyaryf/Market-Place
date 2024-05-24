//
//  NetworkManager.swift
//  store
//
//  Created by Evelina on 10.07.2023.
//

import Moya
import Alamofire

protocol NetworkManagerProtocol {
    var provider: MoyaProvider<RequestManager> { get }
    func registerUser(login: String, password: String, role: String, completion: @escaping (Result<Response, MoyaError>)->())
}

class NetworkManager: NetworkManagerProtocol {
    var provider: Moya.MoyaProvider<RequestManager>
    init(provider: Moya.MoyaProvider<RequestManager>) {
        self.provider = provider
    }
    func registerUser(login: String, password: String, role: String, completion: @escaping (Result<Response, MoyaError>) -> ()) {
        provider.request(.createUser(login: login, password: password, role: role)) { result in
            completion(result)
        }
    }
}
