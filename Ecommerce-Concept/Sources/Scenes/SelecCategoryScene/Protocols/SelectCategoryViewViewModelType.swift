//
//  SelectCategoryViewViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UICollectionView

protocol SelectCategoryViewViewModelType {
    associatedtype Section: Hashable
    associatedtype Item: Hashable
    func generateCollectionViewLayout() -> UICollectionViewLayout
    func recieveCellView(with indexPath: IndexPath,
                         in collectionView: UICollectionView) -> UICollectionViewCell
    func recieveHeaderFooterView(with indexPath: IndexPath,
                                 elementKind: String,
                                 in collectionView: UICollectionView) -> UICollectionReusableView
    func recieveSnapShot() -> NSDiffableDataSourceSnapshot<Section, Item>
}
