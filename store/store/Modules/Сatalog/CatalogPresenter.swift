//
//  CatalogPresenter.swift
//  store
//
//  Created by Evelina on 04.07.2023.
//

import Foundation
import UIKit

class CatalogPresenter {
    var categories: [Category] = [Category(title: Text.Catalog.Categories.clothes, image: UIImage(named: "clothesCategory") ?? UIImage()),
                                          Category(title: Text.Catalog.Categories.home, image: UIImage(named: "homeCategory") ?? UIImage()),
                                          Category(title: Text.Catalog.Categories.beauty, image: UIImage(named: "beautyCategory") ?? UIImage()),
                                          Category(title: Text.Catalog.Categories.accessories, image: UIImage(named: "accessoriesCategory") ?? UIImage()),
                                          Category(title: Text.Catalog.Categories.electronics, image: UIImage(named: "electronicsCategory") ?? UIImage()),
                                          Category(title: Text.Catalog.Categories.children, image: UIImage(named: "childrenCategory") ?? UIImage()),
                                          Category(title: Text.Catalog.Categories.animals, image: UIImage(named: "animalsCategory") ?? UIImage()),
                                          Category(title: Text.Catalog.Categories.sport, image: UIImage(named: "sportCategory") ?? UIImage())]
    var products: [ShortProduct] = [
        ShortProduct(id: 1, price: 28, priceText: "бонуса", name: "Крем увлажняющий", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5),
        ShortProduct(id: 2, price: 34, priceText: "бонуса", name: "Крем питательный", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.3),
        ShortProduct(id: 3, price: 20, priceText: "бонуса", name: "Крем для лица", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5),
        ShortProduct(id: 4, price: 33, priceText: "бонуса", name: "Крем для ног", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5),
        ShortProduct(id: 5, price: 43, priceText: "бонуса", name: "Крем для тела", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5),
        ShortProduct(id: 6, price: 20, priceText: "бонуса", name: "Супер крем", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5),
        ShortProduct(id: 7, price: 30, priceText: "бонуса", name: "Детский крем", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 3.7),
        ShortProduct(id: 8, price: 43, priceText: "бонуса", name: "Крем Бархатные ручки", image: UIImage(named: "exampleProductImage") ?? UIImage(), adminRating: 4.5)
    ]
    private let networkManager: NetworkManagerProtocol
    var didTapToOpenProducts: (([ShortProduct], CatalogPresenter) -> Void)?
    var didTapToAddToCart: ((CartProduct) -> Void)?
    var didTapToAddFilters: (() -> Void)?
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}
extension CatalogPresenter: CatalogViewOutput {
    func viewDidTapToOpenCategory(with index: Int) {
        // отправка запроса и получение листа продуктов
        didTapToOpenProducts?(products, self)
    }
}
extension CatalogPresenter: SearchViewOutput {
    func viewDidTapToOpenFilters() {
        didTapToAddFilters?()
    }
    func viewDidTapToAddProductToCart(with index: Int) {
        let product = products[index]
        let cartProduct = CartProduct(id: product.id, price: product.price, priceText: product.priceText,
                                      name: product.name, image: product.image, amount: 1)
        didTapToAddToCart?(cartProduct)
    }
}
