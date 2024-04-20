//
//  ProductDetailRouter.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 19.04.2024.
//

import Foundation

final class ProductDetailRouter {
    weak var viewController: ProductDetailViewController?
    
    static func createModule() -> ProductDetailViewController {
        
        let view = ProductDetailViewController()
        //let interactor = ProductDetailInteractor()
        let router = ProductDetailRouter()
        
        //let presenter = ProductListingPresenter(view: view, router: router, interactor: interactor)
        
        //view.presenter = presenter
        //interactor.output = presenter
        router.viewController = view
        
        return view
    }
}
