//
//  ErrorResponse.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

final class ErrorResponse: Decodable {
    var code: Int?
    var message: String?
    var messages: [String: String]?
}
