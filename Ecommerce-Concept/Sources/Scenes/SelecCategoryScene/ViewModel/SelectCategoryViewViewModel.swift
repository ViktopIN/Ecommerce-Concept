//
//  SelectCategoryViewViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 16.12.2022.
//

import UIKit

final class SelectCategoryViewViewModel: SelectCategoryViewViewModelType {
    // MARK: - Snapshot configure

    var selectCategoryItems = CategoryItemModel.getConstantValue()
    var hotSalesItems = CategoryItemModel.getValueShopSales()
    var bestSellerItem = CategoryItemModel.getValueBestSeller()
        
    func recieveSnapShot() -> NSDiffableDataSourceSnapshot<Sections, CategoryItemModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, CategoryItemModel>()
        snapshot.appendSections([Sections.selectCategory])
        snapshot.appendItems(selectCategoryItems)
        
        snapshot.appendSections([Sections.hotSales])
        snapshot.appendItems(hotSalesItems)
        
        snapshot.appendSections([Sections.bestSeller])
        snapshot.appendItems(bestSellerItem)
        
        return snapshot
    }

    
    // MARK: - Generate Layout for CollectionView
    
    func generateCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionIdentifier = Sections.allCases[sectionIndex]
            switch sectionIdentifier {
            case .selectCategory:
                return self.selectCategoryLayout()
            case .hotSales:
                return self.hotSalesLayout()
            case .bestSeller:
                return self.bestSellerLayout()
            }
        }
        return layout
    }
    
    private func selectCategoryLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Metrics.selectCategoryItemWidth),
                                                heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        #warning("todo")
        // TODO: - change form below
        let groupWidth = Metrics.selectCategoryItemWidth * 15 + (15 * Metrics.spacingBetweenItemsInCategory)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth),
                                               heightDimension: .fractionalHeight(12/100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                            subitems: [item])
        group.contentInsets = Metrics.selectCategoryGroupInsets
        group.interItemSpacing = .fixed(Metrics.spacingBetweenItemsInCategory)
        
        // Header & footer
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1/10))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: SelectCategoryHeader.sectionHeader,
                                                                 alignment: .top)
        header.contentInsets = Metrics.selectCategoryHeaderInsets
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1/10))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                 elementKind: SelectCategoryFooter.sectionFooter,
                                                                 alignment: .bottom)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header, footer]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = Metrics.selectCategorySectionInsets

        return section
    }
    
    private func hotSalesLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1/5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                            subitems: [item])
        group.contentInsets = Metrics.hotSalesGroupInsets
        
        // Header & footer
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1/10))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: HotSalesHeader.sectionHeader,
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = Metrics.hotSalesSectionInsets

        return section
    }

    private func bestSellerLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                heightDimension: .fractionalWidth(13/20))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = Metrics.bestSellerItemInsets
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // Header & footer
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1/10))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: BestSellerHeader.sectionHeader,
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = Metrics.bestSellerSectionInsets

        return section
    }
    
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
    
    
    func recieveCellView(with indexPath: IndexPath,
                         in collectionView: UICollectionView,
                         itemIdentifier: CategoryItemModel) -> UICollectionViewCell {
        let section = Sections.allCases[indexPath.section]
        switch section {
        case .selectCategory:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.reuseID,
                                                                for: indexPath) as? SelectCategoryCell else { fatalError("change SelectCategoryCell class") }
            if indexPath.row == 0 {
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
            return cell
        case .bestSeller:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.reuseID,
                                                                for: indexPath) as? BestSellerCell else { fatalError("change HotSalesCell class") }
            return cell
        }
    }

}

// MARK: - Extensions

extension SelectCategoryViewViewModel {
    enum Metrics {
        static let selectCategoryItemWidth: CGFloat = 71
        static let spacingBetweenItemsInCategory: CGFloat = 23
        static let selectCategoryHeaderInsets = NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 0,
                                                                       bottom: 18,
                                                                       trailing: 0)
        static let selectCategoryGroupInsets = NSDirectionalEdgeInsets(top: 0,
                                                                       leading: 10,
                                                                       bottom: 0,
                                                                       trailing: 0)
        static let selectCategorySectionInsets = NSDirectionalEdgeInsets(top: 0,
                                                                         leading: 17,
                                                                         bottom: 0,
                                                                         trailing: 30)
        static let windowWidth = UIScreen.main.bounds.width
        static let windowHeight = UIScreen.main.bounds.height
        
        static let hotSalesSectionInsets = NSDirectionalEdgeInsets(top: 0,
                                                                   leading: 15,
                                                                   bottom: 0,
                                                                   trailing: 20)
        static let hotSalesGroupInsets = NSDirectionalEdgeInsets(top: 0,
                                                                 leading: 0,
                                                                 bottom: 0,
                                                                 trailing: 35)

        static let bestSellerSectionInsets = NSDirectionalEdgeInsets(top: 7,
                                                                     leading: 17,
                                                                     bottom: 7,
                                                                     trailing: 21)
        static let bestSellerItemInsets = NSDirectionalEdgeInsets(top: 7,
                                                                  leading: 6,
                                                                  bottom: 7,
                                                                  trailing: 6)

    }
}
