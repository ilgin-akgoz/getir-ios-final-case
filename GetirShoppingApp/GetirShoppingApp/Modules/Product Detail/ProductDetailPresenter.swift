//
//  ProductDetailPresenter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 21.04.2024.
//

import UIKit

protocol ProductDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func tappedBackToList()
    func tappedAddToCart()
}

final class ProductDetailPresenter {
    unowned var view: ProductDetailViewControllerProtocol!
    let router: ProductDetailRouterProtocol!
    let interactor: ProductDetailInteractorProtocol!
    let product: Product!

    init(view: ProductDetailViewControllerProtocol,
         router: ProductDetailRouterProtocol,
         interactor: ProductDetailInteractorProtocol,
         product: Product)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.product = product
    }
    
}

extension ProductDetailPresenter: ProductDetailPresenterProtocol {
    func viewDidLoad() {
        view.setTitle("Ürün Detayı")
        view.setBackgroundColor(.white)
        view.setupNavigationBarButtonItem()
        view.setupTabBar()
        
        interactor.fetchImage(url: URL(string: product.imageURL ?? ""))
    }
    
    func tappedBackToList() {
        router.navigate(.productListing)
    }
    
    func tappedAddToCart() {
        //TODO: add to cart action
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func didFetchImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.view.setupStackView(image: image,
                                     price: self.product.priceText ?? "₺0,00",
                                     name: self.product.name ?? "Product Name",
                                     attribute: self.product.shortDescription ?? "Attribute")
        }
        
    }
    
    func addToCartOutput() {
        
    }
}
