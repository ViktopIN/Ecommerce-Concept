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
    var description: String?
    var isNew: Bool?
    var currentPrice: String?
    var oldPrice: String?
    var isFavorite: Bool?
    
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

// MARK: - Extensions -

extension ItemModel: HotSalesItemModelType {
    
    // MARK: - Initialise
    
    convenience init(name: String,
                     image: UIImage,
                     description: String,
                     isNew: Bool) {
        self.init(name: name,
                  image: image)
        self.description = description
        self.isNew = isNew
    }

    // MARK: - Constant
    
    static func getValueHotSales() -> [ItemModel] {
        let model: [ItemModel] = [
            ItemModel(name: "Iphone 12",
                            image: UIImage(named: "hotSales") ?? UIImage(),
                            description: "Super. Mega. Rapido.",
                            isNew: true),
            ItemModel(name: "Iphone 11",
                            image: UIImage(named: "hotSales") ?? UIImage(),
                            description: "Super. Mega. Rapido.",
                            isNew: false),
            ItemModel(name: "Iphone XR",
                            image: UIImage(named: "hotSales") ?? UIImage(),
                            description: "Super. Mega. Rapido.",
                            isNew: false)
        ]
        return model
    }
}


extension ItemModel: BestSellerItemModelType {
    
    // MARK: - Initialise
    
    convenience init(name: String,
                     image: UIImage,
                     currentPrice: Int?,
                     oldPrice: Int?,
                     isFavorite: Bool?) {
        self.init(name: name,
                  image: image)
        self.currentPrice = currentPrice?.withDollar
        self.oldPrice = oldPrice?.withDollar
        self.isFavorite = isFavorite
    }
    
    // MARK: - Constant
    
    static func getValueBestSeller() -> [ItemModel] {
        let model: [ItemModel] = [
            ItemModel(name: "Xiaomi Mi 10 Pro",
                      image: UIImage(named: "samsung") ?? UIImage(),
                      currentPrice: 300,
                      oldPrice: 400,
                      isFavorite: true),
            ItemModel(name: "Xiaomi Mi 10 Pro",
                      image: UIImage(named: "samsung") ?? UIImage(),
                      currentPrice: 300,
                      oldPrice: 400,
                      isFavorite: false),
            ItemModel(name: "Xiaomi Mi 10 Pro",
                      image: UIImage(named: "samsung") ?? UIImage(),
                      currentPrice: 300,
                      oldPrice: 1200,
                      isFavorite: true),
            ItemModel(name: "Xiaomi Mi 10 Pro",
                      image: UIImage(named: "samsung") ?? UIImage(),
                      currentPrice: 300,
                      oldPrice: 400,
                      isFavorite: false),
            ItemModel(name: "Xiaomi Mi 10 Pro",
                      image: UIImage(named: "samsung") ?? UIImage(),
                      currentPrice: 1500,
                      oldPrice: 400,
                      isFavorite: true),
            ItemModel(name: "Xiaomi Mi 10 Pro",
                      image: UIImage(named: "samsung") ?? UIImage(),
                      currentPrice: 300,
                      oldPrice: 1000,
                      isFavorite: false)
        ]
        return model
    }
}




