//
//  ProductPresenter.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import Foundation
import UIKit

class ProductPresenter {
    
    var product: ExpandedProduct = ExpandedProduct(id: 78, price: "23 бонуса",
                                                   name: "Крем с Алоэ, Греция, пл. упаковка 200 мл",
                                                   description:
    "Восстанавливающий и глубоко увлажняющий крем для рук. Обеспечивает максимальную защиту и мгновенное облегчение для очень сухой, чувствительной и шелушащейся кожи рук.",
                                                   images: [UIImage(named: "exampleProductImage"),
                                                            UIImage(named: "exampleProductImage")],
        admin: Admin(name: "ООО \"AAA\"", rating: 4.5, reviews: "1002 отзыва",
        phoneNumber: "+7 (966) 435 33 11", balance: 5678))
    
    
}
