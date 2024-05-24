//
//  RequestManager.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import Foundation
import Moya
import Alamofire

enum RequestManager {
    case createUser(login: String, password: String, role: String)
}
extension RequestManager: TargetType {
    var baseURL: URL {
        return URL(string: "")!
    }
    var path: String {
        switch self {
            case .createUser: return "/users"
        }
    }
    var method: Moya.Method {
        switch self {
            case .createUser: return .post
        }
    }
    var task: Moya.Task {
        switch self {
            case .createUser (let login, let password, let role):
                let parameters: [String: Any] = [
                    "login": login,
                    "password": password,
                    "role": role
                ]
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    var headers: [String : String]? {
        switch self {
        case .createUser: return .none
        }
    }
}
