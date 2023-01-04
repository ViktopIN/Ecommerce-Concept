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
    
    private var selectCategoryItems: [AnyHashable]
    private var hotSalesItems: [AnyHashable]
    private var bestSellerItem: [AnyHashable]
    
    // MARK: - Initialise
    
    init(selectCategoryItems: [AnyHashable],
         hotSalesItems: [AnyHashable],
         bestSellerItem: [AnyHashable]) {
        self.selectCategoryItems = selectCategoryItems
        self.hotSalesItems = hotSalesItems
        self.bestSellerItem = bestSellerItem
    }
    
    // MARK: - Methods
    
    func recieveSnapShot() -> NSDiffableDataSourceSnapshot<Sections, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, AnyHashable>()
        snapshot.appendSections([Sections.selectCategory])
        snapshot.appendItems(selectCategoryItems)
        
        snapshot.appendSections([Sections.hotSales])
        snapshot.appendItems(hotSalesItems)
        
        snapshot.appendSections([Sections.bestSeller])
        snapshot.appendItems(bestSellerItem)
        
        return snapshot
    }

}


