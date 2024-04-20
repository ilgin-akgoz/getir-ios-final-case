//
//  ProductListingInteractor.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import Foundation

protocol ProductListingInteractorProtocol {
    func fetchProducts() async
    func fetchSuggestedProducts() async
}

protocol ProductListingInteractorOutputProtocol: AnyObject {
    func fetchProductsOutput(_ products: [Product])
    func fetchSuggestedProductsOutput(_ products: [Product])
}

final class ProductListingInteractor {
    var output: ProductListingInteractorOutputProtocol?
    private let productService: ProductsServiceProtocol = ProductsService()
    private let suggestedProductService: SuggestedProductsServiceProtocol = SuggestedProductsService()
}

extension ProductListingInteractor: ProductListingInteractorProtocol {
    func fetchProducts() async {
        do {
            let response = try await productService.getProducts()
            self.output?.fetchProductsOutput(response.first?.products ?? [])
        } catch {
            print(error)
        }
    }
    
    func fetchSuggestedProducts() async {
        do {
            let response = try await suggestedProductService.getSuggestedProducts()
            self.output?.fetchSuggestedProductsOutput(response.first?.products ?? [])
        } catch {
            print(error)
        }
    }
}
