//
//  BestSellerModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 21.12.2022.
//

import Foundation

struct BestSellerModel: Decodable, Hashable {
    var id: Int
    var isFavorites: Bool
    var title: String
    var priceWithoutDiscount: Int
    var discountPrice: Int
    var picture: String
    
    enum BestSellerCodingKey: String, CodingKey {
        case id
        case isFavorites = "is_favorites"
        case title
        case priceWithoutDiscount = "price_without_discount"
        case discountPrice = "discount_price"
        case picture
    }
}
