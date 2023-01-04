//
//  ItemModels.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 19.12.2022.
//

import UIKit

protocol ItemModelType {
    var name: String { get set }
    var image: UIImage { get set }
}

extension ItemModelType {
    
    // MARK: - Protocol Hashable conforming methods
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

protocol CategoryItemModelType: ItemModelType { }

protocol HotSalesItemModelType: ItemModelType {
    var description: String? { get set }
    var isNew: Bool? { get set }
}

protocol BestSellerItemModelType: ItemModelType {
    var currentPrice: String? { get set }
    var oldPrice: String? { get set }
    var isFavorite: Bool? { get set } 
}

