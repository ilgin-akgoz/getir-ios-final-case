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
    func tappedAddToCart()
    func tappedTrash()
    func tappedPlaceOrder()
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
        view.setupTabBar()
    }
    
    func tappedBackToList() {
        router.navigate(.productListing)
    }
    
    func tappedAddToCart() {
        //TODO: add button action
        print("Added to cart!")
    }
     
    func tappedTrash() {
        //TODO: trash button action
        print("Deleted all items!")
    }
    
    func tappedPlaceOrder() {
        //TODO: place order action, alert controller
    }
}
