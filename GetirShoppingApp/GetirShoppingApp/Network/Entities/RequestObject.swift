//
//  RequestObject.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

struct RequestObject {
    var url: String
    let method: HTTPMethod
    var data: Encodable?
    var headers: [String: String]?

    init(url: String,
         method: HTTPMethod = .get,
         data: Encodable? = nil,
         headers: [String: String] = [:]
         ) {
        self.url = url
        self.method = method
        self.data = data
        self.headers = headers
    }
}

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
