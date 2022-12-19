//
//  CellViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 18.12.2022.
//

import UIKit

protocol CellViewModelType {
    func recieveCellView(with indexPath: IndexPath,
                         in collectionView: UICollectionView,
                         itemIdentifier: ItemModel) -> UICollectionViewCell
    func changeItemColorForSelectCategoryGroup(in indexPath: IndexPath,
                                               collectionView: UICollectionView,
                                               dataSource: UICollectionViewDiffableDataSource<Sections,
                                               ItemModel>)
}
