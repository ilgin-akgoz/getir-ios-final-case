//
//  ProductListingRouter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import Foundation

enum ProductListingRoutes {
    case productDetail
    case shoppingCart
}

protocol ProductListingRouterProtocol: AnyObject {
    func navigate(_ route: ProductListingRoutes, with product: Product)
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
    
    func navigate(_ route: ProductListingRoutes, with product: Product) {
        switch route {
        case .productDetail:
            let productDetailVC = ProductDetailRouter.createModule(with: product)
            viewController?.navigationController?.pushViewController(productDetailVC, animated: true)
        case .shoppingCart:
            let shoppingCartVC = ShoppingCartRouter.createModule()
            viewController?.navigationController?.pushViewController(shoppingCartVC, animated: true)
        }
    }
    
}
