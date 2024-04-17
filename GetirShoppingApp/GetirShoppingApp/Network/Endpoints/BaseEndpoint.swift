//
//  BaseEndpoint.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

enum BaseEndpoint: TargetEndpointProtocol {
    case base
    var path: String {
        switch self {
        case .base:
            return Configuration.baseURL
        }
    }
}
