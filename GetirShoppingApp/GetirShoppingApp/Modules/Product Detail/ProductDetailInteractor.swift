//
//  ProductDetailInteractor.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 21.04.2024.
//

import UIKit

protocol ProductDetailInteractorProtocol {
    func fetchImage(url: URL?)
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func fetchImageOutput(_ image: UIImage)
}

final class ProductDetailInteractor {
    weak var output: ProductDetailInteractorOutputProtocol?
    private let imageManager = ImageManager.shared
}

extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    func fetchImage(url: URL?) {
        guard let url else { return }
        
        imageManager.fetchImage(url: url) { result in
            switch result {
            case .success(let imageData):
                if let image = UIImage(data: imageData) {
                    self.output?.fetchImageOutput(image)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
