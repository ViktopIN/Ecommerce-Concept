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
    
    private var selectCategoryItems: [ItemModel]
    private var hotSalesItems: [ItemModel]
    private var bestSellerItem: [ItemModel]
    
    // MARK: - Initialise
    
    init(selectCategoryItems: [ItemModel],
         hotSalesItems: [ItemModel],
         bestSellerItem: [ItemModel]) {
        self.selectCategoryItems = selectCategoryItems
        self.hotSalesItems = hotSalesItems
        self.bestSellerItem = bestSellerItem
    }
    
    // MARK: - Methods
    
    func recieveSnapShot() -> NSDiffableDataSourceSnapshot<Sections, ItemModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, ItemModel>()
        snapshot.appendSections([Sections.selectCategory])
        snapshot.appendItems(selectCategoryItems)
        
        snapshot.appendSections([Sections.hotSales])
        snapshot.appendItems(hotSalesItems)
        
        snapshot.appendSections([Sections.bestSeller])
        snapshot.appendItems(bestSellerItem)
        
        return snapshot
    }

}


