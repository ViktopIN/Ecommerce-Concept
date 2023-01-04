//
//  SelectCategoryViewViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit

protocol SelectCategoryViewViewModelType {
    var collectionViewViewModel: CollectionViewViewModelType { get }
    var collectionViewDataSourceConfigure: CollectionViewDataSourceConfigureClass { get }
    var cellViewModel: CellViewModelType { get }
    var reusableViewModel: ReusableViewModelType { get }
}

