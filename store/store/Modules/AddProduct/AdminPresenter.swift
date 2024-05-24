//
//  AdminPresenter.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import Foundation
import UIKit

class AdminPresenter {
    var products: [ShortProduct] = [ShortProduct(id: 67, price: 67, priceText: "бонусов", name: "Крем с Алоэ", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5),
                                    ShortProduct(id: 67, price: 67, priceText: "бонусов", name: "Крем с Алоэ", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5),
                                    ShortProduct(id: 67, price: 67, priceText: "бонусов", name: "Крем с Алоэ", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5),
                                    ShortProduct(id: 67, price: 67, priceText: "бонусов", name: "Крем с Алоэ", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5)]
    var didTapToAddCategory: ((AdminPresenter) -> Void)?
    var didTapToAddPhotos: ((AdminPresenter) -> Void)?
    var didTapToAddName: ((AdminPresenter) -> Void)?
    var didTapToAddDescription: ((AdminPresenter) -> Void)?
    var didTapToAddCost: ((AdminPresenter) -> Void)?
    var didTapToReturnToProducts: (() -> Void)?
    private var networkManager: NetworkManagerProtocol
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}
extension AdminPresenter: AdminProductViewOutput {
    func viewDidTapToAddProduct() {
        didTapToAddCategory?(self)
    }
}
extension AdminPresenter: ChooseProductCategoryViewOutput {
    func viewDidTapToAddPhotos() {
        didTapToAddPhotos?(self)
    }
}
extension AdminPresenter: ChooseProductImagesViewProtocol {
    func viewDidTapToAddName() {
        didTapToAddName?(self)
    }
}
extension AdminPresenter: AddProductInfoViewOutput {
    func viewDidTapToReturnToProducts() {
        didTapToReturnToProducts?()
    }
    func viewDidTapToAddDescription() {
        didTapToAddDescription?(self)
    }
}
extension AdminPresenter: AddProductDescriptionViewOutput {
    func viewDidTapToAddCost() {
        didTapToAddCost?(self)
    }
}
