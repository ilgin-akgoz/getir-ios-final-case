//
//  UIFont+Extension.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 16.04.2024.
//

import UIKit

extension UIFont {
    static func openSansBold(size: CGFloat) -> UIFont {
        let fontDescriptor = UIFontDescriptor(name: "OpenSans-Bold", size: size)
        return UIFont(descriptor: fontDescriptor, size: size)
    }
}
