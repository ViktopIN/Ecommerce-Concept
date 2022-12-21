//
//  ImageRecieveNetworkService.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 21.12.2022.
//

import UIKit

final class ImageRecieveNetworkService: NetworkServiceType {
    
    typealias AnyModel = UIImage
    
    // MARK: - Properties
    
    static var shared = ImageRecieveNetworkService()
    private var urlSession = URLSession.shared
    var imageURL: URL!
    var image: UIImage!
    
    // MARK: - Methods
    
    func getData()  {
        guard let imageURL = imageURL else { fatalError("unvalid imageURL") }
        urlSession.dataTask(with: imageURL) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse {
                print(response.statusCode)
                self.image = UIImage(data: data)
            } else {
                print("Error")
            }
        }.resume()
    }
}
