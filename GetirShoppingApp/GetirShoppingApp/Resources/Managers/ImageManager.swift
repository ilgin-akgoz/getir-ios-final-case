//
//  ImageManager.swift
//  GetirShoppingApp
//
//  Created by Ilgın Akgöz on 20.04.2024.
//

import Foundation

final class ImageManager {
    static let shared = ImageManager()
    private init() {}
    
    public func fetchImage(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
         guard let url else {
             completion(.failure(URLError(.badURL)))
             return
         }
         
         let request = URLRequest(url: url)
         
         let task = URLSession.shared.dataTask(with: request) { data, _, error in
             guard let data = data, error == nil else {
                 completion(.failure(error ?? URLError(.badServerResponse)))
                 return
             }
             completion(.success(data))
         }
         task.resume()
    }
}
