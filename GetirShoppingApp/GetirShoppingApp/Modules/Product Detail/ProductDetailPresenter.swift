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
    func tappedShoppingCart()
    func tappedAddButton()
    func tappedSubtractButton()
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
        CartManager.shared.addToCart(product)
    }
    
    func tappedShoppingCart() {
        if !CartManager.shared.isCartEmpty() {
            router.navigate(.shoppingCart)
        }
    }
    
    func tappedAddButton() {
        CartManager.shared.addToCart(product)
    }
    
    func tappedSubtractButton() {
        CartManager.shared.removeFromCart(product)
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func fetchImageOutput(_ image: UIImage) {
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
