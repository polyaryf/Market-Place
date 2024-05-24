//
//  OrderPresenter.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import Foundation

class OrderPresenter {
    private let networkManager: NetworkManagerProtocol
    var order: Order
    var productImages: [Data]
    var didTapToMakeOrder: ((Order) -> Void)?
    var didTapToChangeDeliveryInfo: ((Order) -> Void)?
    var didTapToSendOrder: ((Order) -> Void)?
    var didOrderRequestSend: ((Order) -> Void)?
    var didTapToReviewOrder: ((OrderPresenter) -> Void)?
    var didTapToOpenOrderHistoryScreen: (() -> Void)?
    init(networkManager: NetworkManagerProtocol, order: Order) {
        self.networkManager = networkManager
        self.order = order
        self.productImages = order.products.map({$0.image ?? Data()})
    }
}
extension OrderPresenter: DeliveryViewOutput {
    func viewDidTapToPassDeliveryData(country: String, city: String, street: String, building: String) {
        order.address = "\(country), г. \(city), ул. \(street), \(building)"
        order.deliveryDate = "20 июля"
        didTapToMakeOrder?(order)
    }
}
extension OrderPresenter: MakingOrderViewOutput {
    func viewDidTapToReviewOrder() {
        didTapToReviewOrder?(self)
    }
    func viewDidTapToMakeOrder(payment: String) {
        order.payment = payment
        didTapToSendOrder?(order)
        // отправка на сервер
        didOrderRequestSend?(order)
    }
    func viewDidTapToChangeDelivery() {
        didTapToChangeDeliveryInfo?(order)
    }
}
extension OrderPresenter: OrderStatusViewOutput {
    func viewDidTapToOrderHistoryScreen() {
        didTapToOpenOrderHistoryScreen?()
    }
}
