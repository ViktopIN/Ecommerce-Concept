//
//  ReusableViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 18.12.2022.
//

import UIKit

class ReusableViewModel: ReusableViewModelType {
    
    // MARK: - Cells and Header Layout recievers
    
    func recieveHeaderFooterView(with indexPath: IndexPath,
                                 elementKind: String,
                                 in collectionView: UICollectionView) -> UICollectionReusableView {
        switch elementKind {
        case SelectCategoryHeader.sectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                                               withReuseIdentifier: SelectCategoryHeader.reuseID,
                                                                               for: indexPath) as? SelectCategoryHeader else { fatalError("error in SelectCategoryHeader class") }
            return header
        case SelectCategoryFooter.sectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                                               withReuseIdentifier: SelectCategoryFooter.reuseID,
                                                                               for: indexPath) as? SelectCategoryFooter else { fatalError("error in SelectCategoryFooter class") }
            return footer
        case HotSalesHeader.sectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                                               withReuseIdentifier: HotSalesHeader.reuseID,
                                                                               for: indexPath) as? HotSalesHeader else { fatalError("error in HotSalesHeader class") }
            return header
        case BestSellerHeader.sectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                                               withReuseIdentifier: BestSellerHeader.reuseID,
                                                                               for: indexPath) as? BestSellerHeader else { fatalError("error in HotSalesHeader class") }
            return header
        default:
            return UICollectionReusableView()
        }
    }

}
