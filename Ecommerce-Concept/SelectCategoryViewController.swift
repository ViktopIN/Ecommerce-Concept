//
//  SelectCategoryViewController.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 08.12.2022.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    enum Sections: String, CaseIterable {
        case selectCategory
        case hotSales
    }
    
    // MARK: - Views
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Sections, ItemModel>! = nil
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateCollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.register(SelectCategoryCell.self,
                                forCellWithReuseIdentifier: SelectCategoryCell.reuseID)
        collectionView.register(SelectCategoryHeader.self,
                                forSupplementaryViewOfKind: SelectCategoryHeader.sectionHeader,
                                withReuseIdentifier: SelectCategoryHeader.reuseID)
        collectionView.register(SelectCategoryFooter.self,
                                forSupplementaryViewOfKind: SelectCategoryFooter.sectionFooter,
                                withReuseIdentifier: SelectCategoryFooter.reuseID)
        collectionView.register(HotSalesCell.self,
                                forCellWithReuseIdentifier: HotSalesCell.reuseID)
        collectionView.register(HotSalesHeader.self,
                                forSupplementaryViewOfKind: HotSalesHeader.sectionHeader,
                                withReuseIdentifier: HotSalesHeader.reuseID)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        
        view.addSubviews(collectionView)
    }
    
    private func setupLayout() {
        
        collectionView.fillSuperview()
    }
    
    private func setupView() {
        dataSourceConfigure()
    }
}

// MARK: - Extensions

extension SelectCategoryViewController {
    
    // MARK: - CollectionView configure
        
    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionIdentifier = Sections.allCases[sectionIndex]
            switch sectionIdentifier {
            case .selectCategory:
                return self.selectCategoryLayout()
            case .hotSales:
                return self.hotSalesLayout()
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
    
    /// Data source configure
    private func dataSourceConfigure() {
        dataSource = UICollectionViewDiffableDataSource<Sections, ItemModel>(collectionView: self.collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             itemIdentifier: ItemModel) -> UICollectionViewCell? in
            let section = Sections.allCases[indexPath.section]
            switch section {
            case .selectCategory:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.reuseID, for: indexPath) as? SelectCategoryCell else { fatalError("change SelectCategoryCell class") }
                return cell
            case .hotSales:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.reuseID, for: indexPath) as? HotSalesCell else { fatalError("change HotSalesCell class") }
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView,
                                                  elementKind: String,
                                                  indexPath: IndexPath) -> UICollectionReusableView? in
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


            default:
                return UICollectionReusableView()
            }
        }
        dataSource.apply(recieveSnapShot(), animatingDifferences: false)
    }
    
    private func recieveSnapShot() -> NSDiffableDataSourceSnapshot<Sections, ItemModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, ItemModel>()
        snapshot.appendSections([Sections.selectCategory])
        snapshot.appendItems(ItemModel.getValueSelectCategory())
        
        snapshot.appendSections([Sections.hotSales])
        snapshot.appendItems(ItemModel.getValueShopSales())
        
        return snapshot
    }
}
