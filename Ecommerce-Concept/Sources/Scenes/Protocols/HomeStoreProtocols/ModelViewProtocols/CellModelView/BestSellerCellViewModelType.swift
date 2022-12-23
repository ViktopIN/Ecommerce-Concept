//
//  BestSellerCellViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import Foundation

protocol BestSellerCellViewModelType {
    var id: Int { get set }
    var isFavorites: Bool { get set }
    var title: String { get set }
    var priceWithoutDiscount: Int { get set }
    var discountPrice: Int { get set }
    var picture: String { get set }
}
