//
//  ProductCollectionViewCellPresenter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 20.04.2024.
//

import Foundation

protocol ProductCollectionViewCellPresenterProtocol: AnyObject {
    func load()
}

final class ProductCollectionViewCellPresenter {
    weak var view: ProductCollectionViewCellProtocol?
    private let product: Product
    
    init(view: ProductCollectionViewCellProtocol,
         product: Product) {
        self.view = view
        self.product = product
    }
}

extension ProductCollectionViewCellPresenter: ProductCollectionViewCellPresenterProtocol {
    func load() {
        self.view?.setImage(product.imageURL ?? "")
        self.view?.setPriceLabel(product.priceText ?? "₺0,00")
        self.view?.setNameLabel(product.name ?? "Product Name")
        self.view?.setAttributeLabel(product.attribute ?? "Attribute")
    }
}
