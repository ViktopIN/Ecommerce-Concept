//
//  ProductDetail.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 05.01.2023.
//

import UIKit

class ProductDetail {
    
    // MARK: - Properties
    
    var title: String
    var images: [UIImage]
    
    // MARK: - Initialiser
    
    init(model: ProductDetailData) {
        self.title = model.title
        }
    }
}
