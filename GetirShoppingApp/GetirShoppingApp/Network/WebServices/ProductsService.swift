//
//  ProductsService.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

protocol ProductsServiceProtocol {
    func getProducts() async throws -> Product
}

final class ProductsService: ProductsServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = ProductsEndpoint
    let networkLoader: NetworkLoaderProtocol
    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }
    
    func getProducts() async throws -> Product {
        return try await request(with: RequestObject(
            url: build(endpoint: .products)
            ),
            responseModel: Product.self)
    }
}
