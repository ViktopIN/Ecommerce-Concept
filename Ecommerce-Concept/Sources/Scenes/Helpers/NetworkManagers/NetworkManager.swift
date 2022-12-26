//
//  HomeStoreNetworkManager.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit

class NetworkManager {
    
    // MARK: - Properties
        
    private var url: URL
    let condition = NSCondition()
    
    // MARK: - Initialise
    
    init(url: URL) {
        self.url = url
    }
    
    // MARK: - Methods
    
    func getData<T: Decodable>(completion: @escaping (T) -> Void) {
       let session = URLSession.shared.dataTask(with: url) { data, response, error in
           self.condition.signal()
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
        condition.wait()
    }
}
