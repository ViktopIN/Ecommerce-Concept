//
//  SelectCategoryViewViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 16.12.2022.
//

import UIKit

final class SelectCategoryViewViewModel: SelectCategoryViewViewModelType {
    
    // MARK: - Properties
    
    private var selectCategoryItems: [AnyHashable]!
    private var hotSalesItems: [AnyHashable]!
    private var bestSellerItem: [AnyHashable]!
        
    lazy var collectionViewViewModel: CollectionViewViewModelType = CollectionViewViewModel()
    lazy var collectionViewDataSourceConfigure: CollectionViewDataSourceConfigureClass = CollectionViewDataSourceConfigureClass(selectCategoryItems: selectCategoryItems,
                                                hotSalesItems: hotSalesItems,
                                                                                                                                bestSellerItem: bestSellerItem)
    lazy var cellViewModel: CellViewModelType = CellViewModel()
    lazy var reusableViewModel: ReusableViewModelType = ReusableViewModel()
    
    // MARK: - Method
    
    func recieveData() {
        selectCategoryItems = ItemModel.getConstantValue()
        DispatchQueue.global().sync {
            let networkData = MainPageNetworkService.shared
            networkData.getData()
            hotSalesItems = networkData.bestSellerData
            bestSellerItem = networkData.hotSalesData
        }
    }
}

