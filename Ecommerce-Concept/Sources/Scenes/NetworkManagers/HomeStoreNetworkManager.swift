//
//  HomeStoreNetworkManager.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit

class HomeStoreNetworkManager {
    
    // MARK: - Properties
    
    private var url: URL {
        return urlComponents.url!
    }
    private var urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = Strings.urlScheme
        urlComponents.host = Strings.urlHost
        urlComponents.path = Strings.urlPath
        return urlComponents
    }()
    
    let condition = NSCondition()
    
    // MARK: - Methods
    
    func getData(completion: @escaping (MainNetworkModel) -> Void) {
       let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                guard let response = response as? HTTPURLResponse else { return }
                fatalError("Wrong data!\nURL response is\n\(response.statusCode)")
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let returnData = try decoder.decode(MainNetworkModel.self, from: data)
                self.condition.signal()
                completion(returnData)
            } catch let error {
                fatalError("something wrong with MainNetworkModel or urlRequest - \(error)")
            }
        }
        session.resume()
        condition.wait()
    }
}

extension HomeStoreNetworkManager {
    enum Strings {
        static let urlScheme = "https"
        static let urlHost = "run.mocky.io"
        static let urlPath = "/v3/654bd15e-b121-49ba-a588-960956b15175"
    }
}
