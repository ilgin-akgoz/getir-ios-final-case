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
    
    private var totalPrice: Double = 0 {
        didSet {
            NotificationCenter.default.post(name: .cartUpdatedNotification, object: nil)
        }
    }
    
    func getTotalPrice() -> Double {
        return totalPrice
    }
    
    func addToCart(productPrice: Double) {
        totalPrice += productPrice
    }
    
    func removeFromCart(productPrice: Double) {
        totalPrice -= productPrice
        
        if totalPrice < 0 {
            totalPrice = 0
        }
    }
}
