//
//  ItemModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit.UIImage

class CategoryItemModel: Hashable, ItemModelProtocol {
    
    // MARK: - Protocol conforming methods
    
    static func == (lhs: CategoryItemModel, rhs: CategoryItemModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    // MARK: - Properties
    
    var name: String
    var image: UIImage
    
    // MARK: - Initialise
    
    init(name: String,
         image: UIImage) {
        self.name = name
        self.image = image
    }

    // MARK: - Methods
    
    static func getValueShopSales() -> [CategoryItemModel] {
        let model: [CategoryItemModel] = [
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage())
        ]
        return model
    }
    
    static func getValueBestSeller() -> [CategoryItemModel] {
        let model: [CategoryItemModel] = [
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage())
        ]
        return model
    }
    
    static func getConstantValue() -> [CategoryItemModel] {
        return [
            CategoryItemModel(name: "Phones",
                              image: UIImage(named: "phone")!),
            CategoryItemModel(name: "Computers",
                              image: UIImage(named: "computer")!),
            CategoryItemModel(name: "Health",
                              image: UIImage(named: "health")!),
            CategoryItemModel(name: "Books",
                              image: UIImage(named: "book")!),
            CategoryItemModel(name: "Phones",
                              image: UIImage(named: "phone")!),
        ]
    }

}



