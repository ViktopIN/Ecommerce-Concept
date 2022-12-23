//
//  BestSellerCellViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit.UIImage

protocol BestSellerCellViewModelType: AnyObject {
    var id: Int { get }
    var isFavorites: Bool { get }
    var title: String { get }
    var priceWithoutDiscount: NSAttributedString { get }
    var discountPrice: String { get }
    var picture: UIImage { get }
}
