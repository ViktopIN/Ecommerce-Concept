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
                                               dataSource: UICollectionViewDiffableDataSource<Sections,CommonItemModel >) {
        let section = Sections.allCases[indexPath.section]
        if section == .selectCategory {
            guard indexPath != selectedCategorySelectedIndexPath else { return }
            guard let cell = collectionView.cellForItem(at: indexPath) as? SelectCategoryCell,
                  let data = dataSource.itemIdentifier(for: indexPath) else { fatalError() }
            cell.configureCell(configure: data.image,
                               isSelected: true,
                               and: data.name)
            guard let unSelectedCell = collectionView.cellForItem(at: selectedCategorySelectedIndexPath) as?  SelectCategoryCell,
                  let unSelectedData = dataSource.itemIdentifier(for: selectedCategorySelectedIndexPath) else { fatalError() }
            unSelectedCell.configureCell(configure: unSelectedData.image,
                                         isSelected: false,
                                         and: unSelectedData.name)
            selectedCategorySelectedIndexPath = indexPath
        }
    }
    
    // MARK: - Recieve CellView
    
    func recieveCellView(with indexPath: IndexPath,
                         in collectionView: UICollectionView,
                         itemIdentifier: CommonItemModel) -> UICollectionViewCell {
        let section = Sections.allCases[indexPath.section]
        switch section {
        case .selectCategory:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.reuseID,
                                                                for: indexPath) as? SelectCategoryCell else { fatalError("change SelectCategoryCell class") }
            if indexPath.row == 0 {
                selectedCategorySelectedIndexPath = indexPath
                cell.configureCell(configure: itemIdentifier.image,
                                   isSelected: true,
                                   and: itemIdentifier.name)
            } else {
                cell.configureCell(configure: itemIdentifier.image,
                                   isSelected: false,
                                   and: itemIdentifier.name)
            }
            return cell
        case .hotSales:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.reuseID,
                                                                for: indexPath) as? HotSalesCell else { fatalError("change HotSalesCell class") }
            cell.configureCell(model: itemIdentifier)
            return cell
        case .bestSeller:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.reuseID,
                                                                for: indexPath) as? BestSellerCell else { fatalError("change HotSalesCell class") }
            return cell
        }
    }

}
