//
//  CategoryItemModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit.UIImage

struct CategoryItemModel: Hashable {
    var name: String
    var image: UIImage
    var viewColor: UIColor?
    var textColor: UIColor?
    var isSelected: Bool = false
    private let identifier = UUID()
    
    static func getValueSelectCategory() -> [Self] {
        let model: [CategoryItemModel] = [
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
        return model
    }
    static func getValueShopSales() -> [Self] {
        let model: [CategoryItemModel] = [
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage()),
            CategoryItemModel(name: "Name", image: UIImage())
        ]
        return model
    }
    
    static func getValueBestSeller() -> [Self] {
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
}
