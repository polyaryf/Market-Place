//
//  OrderHistoryPresenter.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import UIKit

class OrderHistoryPresenter {
    private let networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    var didTapToOpenOrder: ((Order) -> Void)?
    var orders: [Order] = [
        Order(address: "Казань, Островского, 98", date: "2 июня 2023", payment: "Картой при получении", status: .new, number: "556-55", delivery: .courier, deliveryDate: "15 июля",
              products: []),
        Order(address: "Казань, Островского, 98", date: "2 июня 2023", payment: "Картой при получении", status: .assembly, number: "556-55", delivery: .courier, deliveryDate: "15 июля",
              products: []),
        Order(address: "Казань, Островского, 98", date: "2 июня 2023", payment: "Картой при получении", status: .done, number: "556-55", delivery: .courier, deliveryDate: "15 июля",
              products: [])
    ]
}
extension OrderHistoryPresenter: OrderHistoryViewOutput {
    func viewDidTapToOpenOrder(with index: Int) {
        didTapToOpenOrder?(orders[index])
    }
}
