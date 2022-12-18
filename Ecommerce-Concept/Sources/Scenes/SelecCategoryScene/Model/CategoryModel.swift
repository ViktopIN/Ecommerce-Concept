//
//  ItemModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit.UIImage

class CommonItemModel: Hashable {
    
    // MARK: - Protocol conforming methods
    
    static func == (lhs: CommonItemModel, rhs: CommonItemModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    // MARK: - Properties
    
    var name: String
    var image: UIImage
    var description: String?
    var isNew: Bool?
    
    // MARK: - Initialise
    
    init(name: String,
         image: UIImage) {
        self.name = name
        self.image = image
    }
    
    init(name: String,
         image: UIImage,
         description: String,
         isNew: Bool) {
        self.name = name
        self.image = image
        self.description = description
        self.isNew = isNew
    }

    // MARK: - Constant
        
    static func getValueBestSeller() -> [CommonItemModel] {
        let model: [CommonItemModel] = [
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage()),
            CommonItemModel(name: "Name", image: UIImage())
        ]
        return model
    }
    
    static func getConstantValue() -> [CommonItemModel] {
        return [
            CommonItemModel(name: "Phones",
                              image: UIImage(named: "phone")!),
            CommonItemModel(name: "Computers",
                              image: UIImage(named: "computer")!),
            CommonItemModel(name: "Health",
                              image: UIImage(named: "health")!),
            CommonItemModel(name: "Books",
                              image: UIImage(named: "book")!),
            CommonItemModel(name: "Phones",
                              image: UIImage(named: "phone")!),
        ]
    }
    
    static func getValueHotSales() -> [CommonItemModel] {
        let model: [CommonItemModel] = [
            CommonItemModel(name: "Iphone 12",
                            image: UIImage(named: "hotSales") ?? UIImage(),
                            description: "Super. Mega. Rapido.",
                            isNew: true),
            CommonItemModel(name: "Iphone 11",
                            image: UIImage(named: "hotSales") ?? UIImage(),
                            description: "Super. Mega. Rapido.",
                            isNew: false),
            CommonItemModel(name: "Iphone XR",
                            image: UIImage(named: "hotSales") ?? UIImage(),
                            description: "Super. Mega. Rapido.",
                            isNew: false)
        ]
        return model
    }


}



