//
//  BestSellerModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 21.12.2022.
//

import Foundation

struct BestSellerModel: Decodable {
    var id: Int
    var isFavorites: Bool
    var title: String
    var priceWithoutDiscount: Int
    var discountPrice: Int
    var picture: String
}
