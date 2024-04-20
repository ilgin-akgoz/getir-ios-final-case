//
//  ProductListingEntity.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import Foundation

// Vertical scroll
struct ProductResponse: Decodable {
    let id: String?
    let name: String?
    let productCount: Int?
    let products: [Product]?
    let email: String?
    let password: String?
}

struct Product: Decodable {
    let id: String?
    let name: String?
    let attribute: String?
    let thumbnailURL: String?
    let imageURL: String?
    let price: Double?
    let priceText: String?
    let shortDescription: String?
}

// Horizontal scroll
struct SuggestedProductResponse: Decodable {
    let id: String?
    let name: String?
    let products: [Product]?
}
