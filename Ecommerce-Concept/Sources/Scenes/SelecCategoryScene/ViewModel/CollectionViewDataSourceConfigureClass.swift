//
//  CollectionViewDataSourceConfigureClass.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 18.12.2022.
//

import UIKit

final class CollectionViewDataSourceConfigureClass: CollectionViewDataSourceConfigureType {
    
    // MARK: - Snapshot configure -

    // MARK: - Properties
    
    private var selectCategoryItems: [CommonItemModel]
    private var hotSalesItems: [CommonItemModel]
    private var bestSellerItem: [CommonItemModel]
    
    // MARK: - Initialise
    
    init(selectCategoryItems: [CommonItemModel],
         hotSalesItems: [CommonItemModel],
         bestSellerItem: [CommonItemModel]) {
        self.selectCategoryItems = selectCategoryItems
        self.hotSalesItems = hotSalesItems
        self.bestSellerItem = bestSellerItem
    }
    
    // MARK: - Methods
    
    func recieveSnapShot() -> NSDiffableDataSourceSnapshot<Sections, CommonItemModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, CommonItemModel>()
        snapshot.appendSections([Sections.selectCategory])
        snapshot.appendItems(selectCategoryItems)
        
        snapshot.appendSections([Sections.hotSales])
        snapshot.appendItems(hotSalesItems)
        
        snapshot.appendSections([Sections.bestSeller])
        snapshot.appendItems(bestSellerItem)
        
        return snapshot
    }

}


