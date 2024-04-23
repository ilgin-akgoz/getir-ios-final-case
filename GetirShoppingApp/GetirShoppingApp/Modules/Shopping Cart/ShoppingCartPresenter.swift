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
    //let interactor: ShoppingCartInteractorProtocol!
    
    init(view: ShoppingCartViewControllerProtocol,
         router: ShoppingCartRouterProtocol
         //interactor: ShoppingCartInteractorProtocol,
        )
    {
        self.view = view
        self.router = router
        //self.interactor = interactor
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
        router.navigate(.productListing)
    }
    
    func tappedTrash() {
        CartManager.shared.removeAllProducts()
        view.reloadData()
    }
    
    func tappedPlaceOrder() {
        //TODO: place order action, alert controller
    }
    
    func product(_ index: Int) -> Product? {
        CartManager.shared.getProduct(at: index)
    }
    
    func numberOfItems() -> Int {
        CartManager.shared.getProductCount()
    }
    
    func getTotalPrice() -> String {
        CartManager.shared.getTotalPrice()
    }
}
