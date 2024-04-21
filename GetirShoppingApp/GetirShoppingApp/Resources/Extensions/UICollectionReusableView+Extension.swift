//
//  UICollectionReusableView+Extension.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 21.04.2024.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
