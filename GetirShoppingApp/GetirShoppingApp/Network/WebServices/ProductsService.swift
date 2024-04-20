//
//  ProductsService.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

protocol ProductsServiceProtocol {
    func getProducts() async throws -> [ProductResponse]
}

final class ProductsService: ProductsServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = ProductsEndpoint
    let networkLoader: NetworkLoaderProtocol
    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }
    
    func getProducts() async throws -> [ProductResponse] {
        return try await request(with: RequestObject(
            url: build(endpoint: .products)
            ),
            responseModel: [ProductResponse].self)
    }
}
