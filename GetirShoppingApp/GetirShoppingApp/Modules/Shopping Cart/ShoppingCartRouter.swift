//
//  ShoppingCartRouter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 20.04.2024.
//

import Foundation

final class ShoppingCartRouter {
    weak var viewController: ShoppingCartViewController?
    
    static func createModule() -> ShoppingCartViewController {
        
        let view = ShoppingCartViewController()
        //let interactor = ShoppingCartInteractor()
        let router = ShoppingCartRouter()
        
        //let presenter = ProductListingPresenter(view: view, router: router, interactor: interactor)
        
        //view.presenter = presenter
        //interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
