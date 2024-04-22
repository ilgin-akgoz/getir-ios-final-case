//
//  ShoppingCartRouter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 20.04.2024.
//

import Foundation

enum ShoppingCartRoutes {
    case productListing
}

protocol ShoppingCartRouterProtocol: AnyObject {
    func navigate(_ route: ShoppingCartRoutes)
}

final class ShoppingCartRouter {
    weak var viewController: ShoppingCartViewController?
    
    static func createModule() -> ShoppingCartViewController {
        
        let view = ShoppingCartViewController()
        //let interactor = ShoppingCartInteractor()
        let router = ShoppingCartRouter()
        
        let presenter = ShoppingCartPresenter(view: view, router: router)//, interactor: interactor)
        
        view.presenter = presenter
        //interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension ShoppingCartRouter: ShoppingCartRouterProtocol {
    func navigate(_ route: ShoppingCartRoutes) {
        switch route {
        case .productListing:
            viewController?.navigationController?.popViewController(animated: true)
        }
    }
}
