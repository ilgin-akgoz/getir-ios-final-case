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
        
        let url = URL(string: product.imageURL ?? "")
        
        ImageManager.shared.fetchImage(url: url) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.view.setupStackView(image: UIImage(data: imageData) ?? UIImage(named: "placeholder")!,
                                             price: self.product.priceText ?? "₺0,00",
                                             name: self.product.name ?? "Product Name",
                                             attribute: self.product.shortDescription ?? "Attribute")
                                             }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
    
    func tappedBackToList() {
        router.navigate(.productListing)
    }
    
    func tappedAddToCart() {
        //TODO: 
        print("Added to cart!")
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func addToCartOutput() {
        
    }
}
