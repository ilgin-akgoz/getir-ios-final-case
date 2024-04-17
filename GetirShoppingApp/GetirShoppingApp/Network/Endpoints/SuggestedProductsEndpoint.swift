//
//  SuggestedProductsEndpoint.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

enum SuggestedProductsEndpoint: TargetEndpointProtocol {
    case suggestedProducts
    
    private struct Constants {
        static let suggestedProducts = "/suggestedProducts"
    }
    
    var path: String {
        switch self {
        case .suggestedProducts:
            return BaseEndpoint.base.path + Constants.suggestedProducts
        }
    }
}
