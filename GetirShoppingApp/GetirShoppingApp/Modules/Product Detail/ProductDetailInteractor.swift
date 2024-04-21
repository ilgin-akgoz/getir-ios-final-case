//
//  ProductDetailInteractor.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 21.04.2024.
//

import Foundation

protocol ProductDetailInteractorProtocol {
    func addToCart(product: Product)
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func addToCartOutput()
}

final class ProductDetailInteractor {
    weak var output: ProductDetailInteractorOutputProtocol?
}

extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    func addToCart(product: Product) {
        self.output?.addToCartOutput()
    }
}
