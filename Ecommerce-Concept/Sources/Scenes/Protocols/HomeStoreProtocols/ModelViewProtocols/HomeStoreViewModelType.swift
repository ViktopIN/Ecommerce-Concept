//
//  HomeStoreViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import Foundation

protocol HomeStoreViewModelType {
    // Section model
    var homeStoreSectionsModel: [HomeStoreSectionsModel] { get }
    
    // Item models
    var categoryItemModel: [AnyHashable] { get set }
    var hotSalesItemModel: [AnyHashable] { get set }
    var bestSellerItemModel: [AnyHashable] { get set }
    
    // Cell viewModels
    var selectCategoryCellViewModel: SelectCategoryCellViewModelType { get set }
    var hotSalesCellViewModel: HotSalesCellViewModelType { get set }
    var bestSellerCellViewModel: BestSellerCellViewModelType { get set }
}
