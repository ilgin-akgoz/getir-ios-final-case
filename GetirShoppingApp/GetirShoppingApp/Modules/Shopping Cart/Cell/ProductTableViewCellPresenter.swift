//
//  ProductTableViewCellPresenter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 23.04.2024.
//

import UIKit

protocol ProductTableViewCellPresenterProtocol: AnyObject {
    func load()
    func tappedAddButton()
    func tappedSubtractButton()
}

final class ProductTableViewCellPresenter {
    weak var view: ProductTableViewCellProtocol?
    private let product: Product
    private let cartManager = CartManager.shared
    
    init(view: ProductTableViewCellProtocol,
         product: Product) {
        self.view = view
        self.product = product
    }
}

extension ProductTableViewCellPresenter: ProductTableViewCellPresenterProtocol {
    func load() {
        let url = URL(string: product.imageURL ?? product.squareThumbnailURL ?? "")
        
        ImageManager.shared.fetchImage(url: url) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.view?.setImage(UIImage(data: imageData))
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }

        self.view?.setPriceLabel(product.priceText ?? "₺0,00")
        self.view?.setNameLabel(product.name ?? "Product Name")
        self.view?.setAttributeLabel(product.shortDescription ?? product.attribute ?? "Attribute")
    }
    
    func tappedAddButton() {
        cartManager.addToCart(product)
    }
    
    func tappedSubtractButton() {
        cartManager.removeFromCart(product)
    }
}
