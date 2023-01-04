//
//  CellViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 18.12.2022.
//

import UIKit

class CellViewModel: CellViewModelType {
    
    // MARK: - Selected Category Select Method
    
    private var selectedCategorySelectedIndexPath: IndexPath!
    
    func changeItemColorForSelectCategoryGroup(in indexPath: IndexPath,
                                               collectionView: UICollectionView,
                                               dataSource: UICollectionViewDiffableDataSource<Sections,AnyHashable>) {
        let section = Sections.allCases[indexPath.section]
        if section == .selectCategory {
            guard indexPath != selectedCategorySelectedIndexPath else { return }
            guard let cell = collectionView.cellForItem(at: indexPath) as? SelectCategoryCell,
                  let data = dataSource.itemIdentifier(for: indexPath) as? ItemModelType else { fatalError() }
            cell.configureCell(model: data,
                               selectedState: true)
            guard let unSelectedCell = collectionView.cellForItem(at: selectedCategorySelectedIndexPath) as? SelectCategoryCell,
                  let unSelectedData = dataSource.itemIdentifier(for: selectedCategorySelectedIndexPath) as? ItemModelType
            else { fatalError() }
            unSelectedCell.configureCell(model: unSelectedData,
                                         selectedState: false)
            selectedCategorySelectedIndexPath = indexPath
        }
    }
    
    // MARK: - Recieve CellView
    
    func recieveCellView(with indexPath: IndexPath,
                         in collectionView: UICollectionView,
                         itemIdentifier: AnyHashable) -> UICollectionViewCell {
        let section = Sections.allCases[indexPath.section]
        switch section {
        case .selectCategory:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.reuseID,
                                                                for: indexPath) as? SelectCategoryCell,
                  let itemIdentifier = itemIdentifier as? CategoryItemModelType
            else { fatalError("change SelectCategoryCell class") }
            
            if indexPath.row == 0 {
                selectedCategorySelectedIndexPath = indexPath
                cell.configureCell(model: itemIdentifier,
                                   selectedState: true)
            } else {
                cell.configureCell(model: itemIdentifier,
                                   selectedState: false)
            }
            return cell
        case .hotSales:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.reuseID,
                                                                for: indexPath) as? HotSalesCell,
                  let itemIdentifier = itemIdentifier as? HotSalesModel
            else { fatalError("change HotSalesCell class") }
            cell.configureCell(model: itemIdentifier)
            return cell
        case .bestSeller:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.reuseID,
                                                                for: indexPath) as? BestSellerCell ,
                  let itemIdentifier = itemIdentifier as? BestSellerModel
            else { fatalError("change BestSellerCell class") }
            cell.configureCell(model: itemIdentifier)
            return cell
        }
    }

}
