//
//  MainPageNetworkService.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 21.12.2022.
//

import UIKit

final class MainPageNetworkService: NetworkServiceType {
    
    // MARK: - Properties
    
    static let shared = MainPageNetworkService()
    
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
    
    var hotSalesData: [HotSalesModel]!
    var bestSellerData: [BestSellerModel]!
    
    // MARK: - Methods
    
    func getData()  {
        URLSession.shared.dataTask(with: url) {  data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                print(response.statusCode)
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let returnedData = try decoder.decode(MainNetworkModel.self, from: data)
                    self.bestSellerData = returnedData.bestSeller
                    self.hotSalesData = returnedData.homeStore
                } catch let decodeError  {
                    print("\(decodeError.localizedDescription)")
                }

            } else {
                print("Error")
            }
        }.resume()
    }
}

extension MainPageNetworkService {
    enum Strings {
        static let urlScheme = "https"
        static let urlHost = "run.mocky.io"
        static let urlPath = "/v3/654bd15e-b121-49ba-a588-960956b15175"
    }
}
