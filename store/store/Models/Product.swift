//
//  Product.swift
//  store
//
//  Created by Evelina on 01.07.2023.
//

import UIKit

struct ShortProduct {
    let id: Int64
    let price: Int
    let priceText: String
    let name: String
    let image: UIImage
    let adminRating: Double
}
struct ExpandedProduct {
    let id: Int64
    let price: String
    let name: String
    let description: String
    let images: [UIImage?]
    let admin: Admin
}
struct CartProduct {
    let id: Int64
    let price: Int
    let priceText: String
    let name: String
    let image: UIImage
    var amount: Int
}
