//
//  ItemModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit.UIImage

class ItemModel: CategoryItemModelType, Hashable {
    
    // MARK: - Properties
    
    var name: String
    var image: UIImage
    
    // MARK: - Initialise
    
    init(name: String,
         image: UIImage) {
        self.name = name
        self.image = image
    }

    // MARK: - Constant
            
    static func getConstantValue() -> [ItemModel] {
        return [
            ItemModel(name: "Phones",
                              image: UIImage(named: "phone")!),
            ItemModel(name: "Computers",
                              image: UIImage(named: "computer")!),
            ItemModel(name: "Health",
                              image: UIImage(named: "health")!),
            ItemModel(name: "Books",
                              image: UIImage(named: "book")!),
            ItemModel(name: "Phones",
                              image: UIImage(named: "phone")!),
        ]
    }
}



