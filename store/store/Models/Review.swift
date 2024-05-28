//
//  Review.swift
//  store
//
//  Created by Полина Рыфтина on 28.05.2024.
//

import Foundation

struct Review {
    let id: Int64
    let user: User
    let product: Product
    let message: String
    let source: Int
}
