//
//  CartManager.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 22.04.2024.
//

import Foundation

final class CartManager {
    static let shared = CartManager()

    private init() {}
    
    private var products: [Product] = []
    
    private var totalPrice: Double = 0 {
        didSet {
            NotificationCenter.default.post(name: .cartUpdatedNotification, object: nil)
        }
    }
    
    func getTotalPrice() -> String {
        "₺\(totalPrice)"
    }
    
    func getProductCount() -> Int {
        products.count
    }
    
    func getProduct(at index: Int) -> Product {
        products[index]
    }
    
    func addToCart(_ product: Product) {
        if products.contains(where: { $0.id == product.id }) {
            totalPrice += product.price ?? 0
            return
        }
        totalPrice += product.price ?? 0
        products.append(product)
    }
    
    func removeFromCart(_ product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            let removedProduct = products.remove(at: index)
            totalPrice -= removedProduct.price ?? 0
            if totalPrice < 0 {
                totalPrice = 0
            }
        }
    }
    
    func removeAllProducts() {
        products.removeAll()
        totalPrice = 0
    }
    
    func isCartEmpty() -> Bool {
        totalPrice == 0 ? true : false
    }
}
