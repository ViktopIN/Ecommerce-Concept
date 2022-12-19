//
//  ReusableViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 18.12.2022.
//

import UIKit

protocol ReusableViewModelType {
    func recieveHeaderFooterView(with indexPath: IndexPath,
                                 elementKind: String,
                                 in collectionView: UICollectionView) -> UICollectionReusableView
}
