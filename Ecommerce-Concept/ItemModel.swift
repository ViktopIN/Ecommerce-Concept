//
//  ItemModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit.UIImage

struct ItemModel: Hashable {
    var name: String
    var image: UIImage
    private let identifier = UUID()
    
    static func getValueSelectCategory() -> [Self] {
        let model: [ItemModel] = [
            ItemModel(name: "Name", image: UIImage()),
            ItemModel(name: "Name", image: UIImage()),
            ItemModel(name: "Name", image: UIImage()),
            ItemModel(name: "Name", image: UIImage()),
            ItemModel(name: "Name", image: UIImage())
        ]
        return model
    }
    static func getValueShopSales() -> [Self] {
        let model: [ItemModel] = [
            ItemModel(name: "Name", image: UIImage()),
            ItemModel(name: "Name", image: UIImage()),
            ItemModel(name: "Name", image: UIImage())

        ]
        return model
    }

}
