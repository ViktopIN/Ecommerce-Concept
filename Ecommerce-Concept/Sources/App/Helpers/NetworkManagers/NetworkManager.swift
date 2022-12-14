//
//  HomeStoreNetworkManager.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit

final class NetworkManager {
    
    // MARK: - Properties
        
    private var url: URL
    private var condition = NSCondition()
    
    // MARK: - Initialise
    
    init(url: URL?) {
        guard let url = url else { fatalError() }
        self.url = url
    }
    
    // MARK: - Methods
    
    func getData<T: Decodable>(completion: @escaping (T) -> Void) {
       let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                guard let response = response as? HTTPURLResponse else { return }
                fatalError("Wrong data!\nURL response is\n\(response.statusCode)")
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let returnData = try decoder.decode(T.self, from: data)
                completion(returnData)
                self.condition.signal()
            } catch let error {
                fatalError("something wrong with model or urlRequest - \(error)")
            }
        }
        session.resume()
        condition.wait()
    }
    
    func getData2<T: Decodable>(completion: @escaping (T) -> Void) {
       let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                guard let response = response as? HTTPURLResponse else { return }
                fatalError("Wrong data!\nURL response is\n\(response.statusCode)")
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let returnData = try decoder.decode(T.self, from: data)
                completion(returnData)
            } catch let error {
                fatalError("something wrong with model or urlRequest - \(error)")
            }
        }
        session.resume()
    }

    
    static func loadingImageData(imageURL: URL?, completion: @escaping (UIImage) -> Void) {
        guard let imageURL = imageURL else { return }
        let session = URLSession.shared
        session.dataTask(with: imageURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                return
            }
        }.resume()
    }
}
