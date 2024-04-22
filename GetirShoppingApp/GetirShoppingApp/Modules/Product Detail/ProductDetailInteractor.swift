//
//  ProductDetailInteractor.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 21.04.2024.
//

import UIKit

protocol ProductDetailInteractorProtocol {
    func fetchImage(url: URL?)
    func addToCart(product: Product)
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func didFetchImage(_ image: UIImage)
    func addToCartOutput()
}

final class ProductDetailInteractor {
    weak var output: ProductDetailInteractorOutputProtocol?
    let imageManager: ImageManager
    
    init(imageManager: ImageManager = ImageManager.shared) {
        self.imageManager = imageManager
    }
}

extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    func fetchImage(url: URL?) {
        guard let url else { return }
        
        imageManager.fetchImage(url: url) { result in
            switch result {
            case .success(let imageData):
                if let image = UIImage(data: imageData) {
                    self.output?.didFetchImage(image)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addToCart(product: Product) {
        self.output?.addToCartOutput()
    }
}
