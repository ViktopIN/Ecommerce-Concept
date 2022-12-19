//
//  SelectCategoryViewViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 16.12.2022.
//

import UIKit

final class SelectCategoryViewViewModel: SelectCategoryViewViewModelType {
    
    // MARK: - Properties
    
    private var selectCategoryItems = ItemModel.getConstantValue()
    private var hotSalesItems = ItemModel.getValueHotSales()
    private var bestSellerItem = ItemModel.getValueBestSeller()
    
    lazy var collectionViewViewModel: CollectionViewViewModelType = CollectionViewViewModel()
    lazy var collectionViewDataSourceConfigure: CollectionViewDataSourceConfigureClass = CollectionViewDataSourceConfigureClass(selectCategoryItems: selectCategoryItems,
                                                                                                                                hotSalesItems: hotSalesItems,
                                                                                                                                bestSellerItem: bestSellerItem)
    lazy var cellViewModel: CellViewModelType = CellViewModel()
    lazy var reusableViewModel: ReusableViewModelType = ReusableViewModel()
}

