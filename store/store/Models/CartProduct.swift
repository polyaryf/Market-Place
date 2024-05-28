//
//  CartProduct.swift
//  store
//
//  Created by Полина Рыфтина on 28.05.2024.
//

import Foundation

struct CartProduct {
    let id: Int64
    let cart: Cart
    let product: Product
    let count: Int
    let state: State
}
