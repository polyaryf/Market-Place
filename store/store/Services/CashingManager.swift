//
//  CashingManager.swift
//  store
//
//  Created by Evelina on 10.07.2023.
//

import CoreData
import UIKit
import Foundation

protocol CashingManagerProtocol {
    func getCachedCartProducts() -> [Product]?
    func addProductToCache(newProduct: CartProduct) -> Product?
    func deleteProductFromCache(productToDelete: Product) -> Bool
    func updateProductAmount(product: Product, newAmount: Int32) -> Bool
    func deleteAllProducts() -> Bool
}

class CashingManager: CashingManagerProtocol {
    private let context: NSManagedObjectContext? = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        return appDelegate.persistentContainer.viewContext
    }()
    func getCachedCartProducts() -> [Product]? {
        guard let unwrappedContext = context else {
            return nil
        }
        do {
            let products = try unwrappedContext.fetch(Product.fetchRequest())
            return products
        } catch {
            return nil
        }
    }
    func addProductToCache(newProduct: CartProduct) -> Product? {
        guard let unwrappedContext = context else {
            return nil
        }
        let product = Product(context: unwrappedContext)
        product.price = Int32(newProduct.price)
        product.name = newProduct.name
        product.amount = Int32(newProduct.amount)
        product.image = newProduct.image.pngData()
        product.id = newProduct.id
        do {
            try unwrappedContext.save()
            return product
        } catch {
            return nil
        }
    }
    func deleteProductFromCache(productToDelete: Product) -> Bool {
        guard let unwrappedContext = context else {
            return false
        }
        unwrappedContext.delete(productToDelete)
        do {
            try unwrappedContext.save()
            return true
        } catch {
            return false
        }
    }
    func updateProductAmount(product: Product, newAmount: Int32) -> Bool {
        guard let unwrappedContext = context else {
            return false
        }
        product.amount = newAmount
        do {
            try unwrappedContext.save()
            return true
        } catch {
            return false
        }
    }
    func deleteAllProducts() -> Bool {
        guard let unwrappedContext = context else {
            return false
        }
        guard let products = getCachedCartProducts() else {return false}
        products.forEach({unwrappedContext.delete($0)})
        do {
            try unwrappedContext.save()
            return true
        } catch {
            return false
        }
    }
}
