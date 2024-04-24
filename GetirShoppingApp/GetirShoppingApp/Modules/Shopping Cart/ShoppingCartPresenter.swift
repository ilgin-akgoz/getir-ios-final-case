//
//  ShoppingCartPresenter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 22.04.2024.
//

import Foundation

protocol ShoppingCartPresenterProtocol: AnyObject {
    func viewDidLoad()
    func tappedBackToList()
    func tappedTrash()
    func tappedPlaceOrder()
    func product(_ index: Int) -> Product?
    func numberOfItems() -> Int
    func getTotalPrice() -> String
}

final class ShoppingCartPresenter {
    unowned var view: ShoppingCartViewControllerProtocol!
    let router: ShoppingCartRouterProtocol!
    private let cartManager = CartManager.shared
    
    init(view: ShoppingCartViewControllerProtocol,
         router: ShoppingCartRouterProtocol
        )
    {
        self.view = view
        self.router = router
    }
    
}

extension ShoppingCartPresenter: ShoppingCartPresenterProtocol {
    func viewDidLoad() {
        view.setTitle("Sepetim")
        view.setBackgroundColor(.white)
        view.setupNavigationBarButtonItems()
        view.setupTableView()
        view.setupTabBar()
        view.reloadData()
    }
    
    func tappedBackToList() {
        router.navigate(.productDetail)
    }
    
    func tappedTrash() {
        cartManager.removeAllProducts()
        view.reloadData()
    }
    
    func tappedPlaceOrder() {
        cartManager.removeAllProducts()
        router.navigate(.productListing)
    }
    
    func product(_ index: Int) -> Product? {
        cartManager.getProduct(at: index)
    }
    
    func numberOfItems() -> Int {
        cartManager.getProductCount()
    }
    
    func getTotalPrice() -> String {
        cartManager.getTotalPrice()
    }
}
