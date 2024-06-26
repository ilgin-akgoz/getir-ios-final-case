//
//  ProductListingPresenter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import Foundation

protocol ProductListingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func suggestedNumberOfItems() -> Int
    func numberOfItems() -> Int
    func suggestedProduct(_ index: Int) -> Product?
    func product(_ index: Int) -> Product?
    func tappedShoppingCart()
    func didSelectItem(_ selectedProduct: Product)
}

final class ProductListingPresenter {
    unowned var view: ProductListingViewControllerProtocol!
    let router: ProductListingRouterProtocol!
    let interactor: ProductListingInteractorProtocol!
    
    private var suggestedProducts: [Product] = []
    private var products: [Product] = []
    
    init(view: ProductListingViewControllerProtocol,
         router: ProductListingRouterProtocol,
         interactor: ProductListingInteractorProtocol)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension ProductListingPresenter: ProductListingPresenterProtocol {
    
    func viewDidLoad() {
        view.setTitle("Ürünler")
        view.setBackgroundColor(.backgroundColor)
        view.setupNavigationBarButtonItem()
        view.setupCollectionView()
        
        Task {
            await fetchSuggestedProducts()
            await fetchProducts()
        }
    }
    
    func suggestedNumberOfItems() -> Int {
        suggestedProducts.count
    }
    
    func numberOfItems() -> Int {
        products.count
    }
    
    func suggestedProduct(_ index: Int) -> Product? {
        suggestedProducts[index]
    }
    
    func product(_ index: Int) -> Product? {
        products[index]
    }
    
    func tappedShoppingCart() {
        if !CartManager.shared.isCartEmpty() {
            router.navigate()
        }
    }
    
    func didSelectItem(_ selectedProduct: Product) {
        router.navigate(with: selectedProduct)
    }
    
    private func fetchSuggestedProducts() async {
        await interactor.fetchSuggestedProducts()
    }
    
    private func fetchProducts() async {
        await interactor.fetchProducts()
    }
}

extension ProductListingPresenter: ProductListingInteractorOutputProtocol {
    func fetchSuggestedProductsOutput(_ products: [Product]) {
        self.suggestedProducts = products
        view.reloadData()
    }
    
    func fetchProductsOutput(_ products: [Product]) {
        self.products = products
        view.reloadData()
    }
}
