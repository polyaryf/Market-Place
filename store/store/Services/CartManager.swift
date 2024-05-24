//
//  CartManager.swift
//  store
//
//  Created by Evelina on 11.07.2023.
//

import Foundation

protocol CartManagerProtocol {
    func addProductToCart(product: CartProduct)
    func getProductsFromCart(comletion: (([Product]) -> Void))
    func deleteProductFromCart(product: Product)
    func updateProductAmount(product: Product, newAmount: Int32)
    func deleteAllProducts()
    var cart: [Product] {get}
}

class CartManager: CartManagerProtocol {
    var cart: [Product]  = []
    private var cashingManager: CashingManagerProtocol
    init(cashingManager: CashingManagerProtocol) {
        self.cashingManager = cashingManager
        cart = getProducts()
    }
    private func getProducts() -> [Product] {
        guard let products = cashingManager.getCachedCartProducts() else {return []}
        return products
    }
    func getProductsFromCart(comletion: (([Product]) -> Void)) {
        comletion(getProducts())
    }
    func addProductToCart(product: CartProduct) {
        guard let addedProduct = cashingManager.addProductToCache(newProduct: product) else { return}
        cart.append(addedProduct)
    }
    func deleteProductFromCart(product: Product) {
        if let index = cart.firstIndex(where: { cartProduct in
            cartProduct.id == product.id
        }) {
            cart.remove(at: index)
            cashingManager.deleteProductFromCache(productToDelete: product)
        }
    }
    func updateProductAmount(product: Product, newAmount: Int32) {
        if let index = cart.firstIndex(where: { cartProduct in
            cartProduct.id == product.id
        }) {
            cart[index].amount = newAmount
            cashingManager.updateProductAmount(product: product, newAmount: newAmount)
        }
    }
    func deleteAllProducts() {
        cashingManager.deleteAllProducts()
    }
}
