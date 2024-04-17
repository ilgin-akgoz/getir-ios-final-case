//
//  ProductListingEntity.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import Foundation

// Vertical scroll
struct Product: Decodable {
    let id: String?
    let name: String?
    let productCount: Int?
    let products: [ProductDetail]
    
    struct ProductDetail: Decodable {
        let id: String?
        let name: String?
        let attribute: String?
        let thumbnailURL: String?
        let imageURL: String?
        let price: Double?
        let priceText: String?
    }
}

// Horizontal scroll
struct SuggestedProduct: Decodable {
    let products: [SuggestedProductDetail]
    
    struct SuggestedProductDetail: Decodable {
        let id: String?
        let imageURL: String?
        let price: Double?
        let name: String?
        let priceText: String?
        let shortDescription: String?
    }
}
