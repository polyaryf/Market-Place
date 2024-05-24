//
//  CartPresenter.swift
//  store
//
//  Created by Evelina on 05.07.2023.
//

import UIKit

class CartPresenter {
    private let networkManager: NetworkManagerProtocol
    weak var view: CartViewController?
    var didTapToMakeOrder: ((Order) -> Void)?
    var didTapToChangeAmount: ((Product, Int32) -> Void)?
    var didTapToDeleteProduct: ((Product) -> Void)?
    var didTapToDeleteAllProducts: (() -> Void)?
    var didTapToGetCartProducts: ((([Product]) -> Void) -> ())?
    var products: [Product] = []
    init(networkManager: NetworkManagerProtocol, products: [Product]) {
        self.networkManager = networkManager
        self.products = products
    }
}
extension CartPresenter: CartViewOutput {
    func viewDidTapToMakeOrder() {
        didTapToMakeOrder?(Order(address: "", date: "", payment: "", status: .new, number: "", delivery: .courier, deliveryDate: "", products: products))
    }
    func viewDidTapToChangeAmount(with index: Int) {
        didTapToChangeAmount?(products[index], products[index].amount)
    }
    func viewDidTapToDeleteProduct(with indexPath: IndexPath) {
        didTapToDeleteProduct?(products[indexPath.row])
        products.remove(at: indexPath.row)
        DispatchQueue.main.async {
            self.view?.deleteCollectionViewCell(indexPath: indexPath)
        }
    }
    func viewDidTapToDeleteAllProducts() {
        didTapToDeleteAllProducts?()
    }
    func viewDidTapToUpdateCart() {
        didTapToGetCartProducts?({ cart in
            products = cart
            DispatchQueue.main.async {
                self.view?.updateCollectionView()
            }
        })
    }
}
