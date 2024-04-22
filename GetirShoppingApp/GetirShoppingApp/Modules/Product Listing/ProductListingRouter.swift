//
//  ProductListingRouter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import Foundation

protocol ProductListingRouterProtocol: AnyObject {
    func navigate()
    func navigate(with product: Product)
}

final class ProductListingRouter {
    
    weak var viewController: ProductListingViewController?
    
    static func createModule() -> ProductListingViewController {
        
        let view = ProductListingViewController()
        let interactor = ProductListingInteractor()
        let router = ProductListingRouter()
        
        let presenter = ProductListingPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
}

extension ProductListingRouter: ProductListingRouterProtocol {
    
    func navigate(with product: Product) {
        let productDetailVC = ProductDetailRouter.createModule(with: product)
        viewController?.navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    func navigate() {
        let shoppingCartVC = ShoppingCartRouter.createModule()
        viewController?.navigationController?.pushViewController(shoppingCartVC, animated: true)
    }
}
