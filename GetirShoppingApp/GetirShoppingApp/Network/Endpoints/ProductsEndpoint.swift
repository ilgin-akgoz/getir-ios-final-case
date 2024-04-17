//
//  ProductsEndpoint.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

enum ProductsEndpoint: TargetEndpointProtocol {
    case products
    
    private struct Constants {
        static let products  = "/products"
    }
    
    var path: String {
        switch self {
        case .products:
            return BaseEndpoint.base.path + Constants.products
        }
    }
}
