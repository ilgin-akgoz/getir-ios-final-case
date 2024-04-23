//
//  ProductDetailRouter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 19.04.2024.
//

import Foundation

enum ProductDetailRoutes {
    case productListing
    case shoppingCart
}

protocol ProductDetailRouterProtocol: AnyObject {
    func navigate(_ route: ProductDetailRoutes)
}

final class ProductDetailRouter {
    weak var viewController: ProductDetailViewController?
    
    static func createModule(with product: Product) -> ProductDetailViewController {
        
        let view = ProductDetailViewController()
        let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter()
        
        let presenter = ProductDetailPresenter(view: view, router: router, interactor: interactor, product: product)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension ProductDetailRouter: ProductDetailRouterProtocol {
    
    func navigate(_ route: ProductDetailRoutes) {
        switch route {
        case .productListing:
            viewController?.navigationController?.popViewController(animated: true)
        case .shoppingCart:
            let shoppingCartVC = ShoppingCartRouter.createModule()
            viewController?.navigationController?.pushViewController(shoppingCartVC, animated: true)
        }
    }
    
}
