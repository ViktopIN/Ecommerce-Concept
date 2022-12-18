//
//  CollectionViewViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 18.12.2022.
//

import UIKit

final class CollectionViewViewModel: CollectionViewViewModelType {

    // MARK: - Layout Generation
    
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
    
    /// SelectCategorySection Layout
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
                                                heightDimension: .fractionalHeight(1/12))
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
    
    /// HotSalesSection Layout
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
                                                heightDimension: .absolute(Metrics.hotSalesHeaderHeight))
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

    /// BestSellerSection Layout
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
}

// MARK: - Extensions

extension CollectionViewViewModel {
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
        
        static let hotSalesHeaderHeight: CGFloat = 32
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
