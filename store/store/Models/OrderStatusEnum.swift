//
//  OrderStatusEnum.swift
//  store
//
//  Created by Evelina on 08.07.2023.
//

import Foundation

enum OrderStatusEnum: String {
    case new = "Новый"
    case assembly = "В сборке"
    case delivery = "В доставкe"
    case done = "Получен"
    case canceled = "Отменен"
}
