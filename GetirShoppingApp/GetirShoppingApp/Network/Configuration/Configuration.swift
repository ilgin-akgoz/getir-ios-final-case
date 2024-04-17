//
//  Configuration.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 17.04.2024.
//

import Foundation

enum ConfigurationError: Swift.Error {
    case missingKey, invalidValue
}

protocol ConfigurationProtocol {}

extension ConfigurationProtocol {
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw ConfigurationError.missingKey
        }
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw ConfigurationError.invalidValue
        }
    }
}

final class Configuration: ConfigurationProtocol {
    static var baseURL: String {
        let url: String? = try? self.value(for: "BASE_URL")
        return url ?? ""
    }
}
