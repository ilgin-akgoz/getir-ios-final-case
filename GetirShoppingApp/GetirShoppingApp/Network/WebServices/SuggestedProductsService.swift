//
//  SuggestedProductsService.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

protocol SuggestedProductsServiceProtocol {
    func getSuggestedProducts() async throws -> SuggestedProduct
}

final class SuggestedProductsService: SuggestedProductsServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = SuggestedProductsEndpoint
    let networkLoader: NetworkLoaderProtocol
    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }
    
    func getSuggestedProducts() async throws -> SuggestedProduct {
        return try await request(with: RequestObject(
            url: build(endpoint: .suggestedProducts)
            ),
            responseModel: SuggestedProduct.self)
    }
}
