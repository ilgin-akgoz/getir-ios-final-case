//
//  NetworkLoaderProvider.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

final class NetworkLoaderProvider {
    static let shared: NetworkLoaderProvider = NetworkLoaderProvider()
    let networkLoader: NetworkLoaderProtocol
    private init() {
        networkLoader = NetworkLoader()
    }
}
