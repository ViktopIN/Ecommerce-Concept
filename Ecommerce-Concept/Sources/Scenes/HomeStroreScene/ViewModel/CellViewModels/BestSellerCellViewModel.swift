//
//  BestSellerCellViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit

class BestSellerCellViewModel: BestSellerCellViewModelType {    
    
    // MARK: - Properties
    
    var bestSellerModel: BestSellerModel
    
    var id: Int {
        bestSellerModel.id
    }
    var isFavorites: Bool {
        bestSellerModel.isFavorites
    }
    var title: String {
        bestSellerModel.title
    }
    var priceWithoutDiscount: NSAttributedString {
        let priceWithoutDiscountTextAttribute: [NSAttributedString.Key: Any]
                = [NSAttributedString.Key.font: UIFont.markProMedium(ofSize: Metrics.priceWithoutDiscountTextSize),
                   NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                   NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        let priceWithoutDiscountText = NSAttributedString(string:   bestSellerModel.priceWithoutDiscount.withDollar ,
                                                          attributes: priceWithoutDiscountTextAttribute)
        return priceWithoutDiscountText
    }
    var discountPrice: String {
        bestSellerModel.discountPrice.withDollar
    }
    var picture: UIImage {
        var image = UIImage()
        let data = try? Data(contentsOf: URL(string: self.bestSellerModel.picture)!)
        image = UIImage(data: data ?? Data()) ?? UIImage()
        return image
    }
    
    // MARK: - Initialise
    
    init(bestSellerModel: BestSellerModel) {
        self.bestSellerModel = bestSellerModel
    }
}

extension BestSellerCellViewModel {
    enum Metrics {
        static let priceWithoutDiscountTextSize: CGFloat = 10
    }
}
