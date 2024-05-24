//
//  Order.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import Foundation

struct Order {
    var address: String
    let date: String
    var payment: String
    let status: OrderStatusEnum
    let number: String
    let delivery: DeliveryEnum
    var deliveryDate: String
    let products: [Product]
}
