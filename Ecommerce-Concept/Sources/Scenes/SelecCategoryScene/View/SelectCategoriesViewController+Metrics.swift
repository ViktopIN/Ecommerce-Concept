//
//  SelectCategoriesViewController+Metrics.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit

extension SelectCategoryViewController {
    enum Metrics {
        static let selectCategoryItemWidth: CGFloat = 71
        static let spacingBetweenItemsInCategory: CGFloat = 23
        static let selectCategoryGroupInsets = NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 10,
                                                                       bottom: 0,
                                                                       trailing: 0)
        static let selectCategorySectionInsets = NSDirectionalEdgeInsets(top: 0,
                                                                         leading: 17,
                                                                         bottom: 0,
                                                                         trailing: 0)
        static let windowWidth = UIScreen.main.bounds.width
        static let windowHeight = UIScreen.main.bounds.height
        
        static let hotSalesSectionInsets = NSDirectionalEdgeInsets(top: 0,
                                                                   leading: 15,
                                                                   bottom: 0,
                                                                   trailing: 20)
        static let hotSalesGroupInsets = NSDirectionalEdgeInsets(top: 0,
                                                                 leading: 0,
                                                                 bottom: 0,
                                                                 trailing: 35)

        static let bestSellerSectionInsets = NSDirectionalEdgeInsets(top: 7,
                                                                     leading: 17,
                                                                     bottom: 7,
                                                                     trailing: 21)
        static let bestSellerItemInsets = NSDirectionalEdgeInsets(top: 7,
                                                                  leading: 6,
                                                                  bottom: 7,
                                                                  trailing: 6)
    }
}

