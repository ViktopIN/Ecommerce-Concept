//
//  HomeStoreControllerView.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 08.12.2022.
//

import UIKit

class HomeStoreControllerView: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: HomeStoreViewModelType!
    
    // MARK: - Views
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<HomeStoreSectionsModel, AnyHashable>! = nil
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
        collectionView.register(BestSellerCell.self,
                                forCellWithReuseIdentifier: BestSellerCell.reuseID)
        collectionView.register(BestSellerHeader.self,
                                forSupplementaryViewOfKind: BestSellerHeader.sectionHeader,
                                withReuseIdentifier: BestSellerHeader.reuseID)


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

extension HomeStoreControllerView {
    
    // MARK: - CollectionView configure
        
    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionIdentifier = HomeStoreSectionsModel.allCases[sectionIndex]
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

    
    /// Data source configure
    private func dataSourceConfigure() {
        dataSource = UICollectionViewDiffableDataSource<HomeStoreSectionsModel, AnyHashable>(collectionView: self.collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             itemIdentifier: AnyHashable) -> UICollectionViewCell? in
            let section = HomeStoreSectionsModel.allCases[indexPath.section]
            switch section {
            case .selectCategory:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.reuseID, for: indexPath) as? SelectCategoryCell else { fatalError("change SelectCategoryCell class") }
                return cell
            case .hotSales:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.reuseID, for: indexPath) as? HotSalesCell else { fatalError("change HotSalesCell class") }
                return cell
            case .bestSeller:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.reuseID, for: indexPath) as? BestSellerCell else { fatalError("change HotSalesCell class") }
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
            case BestSellerHeader.sectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                                                   withReuseIdentifier: BestSellerHeader.reuseID,
                                                                                   for: indexPath) as? BestSellerHeader else { fatalError("error in HotSalesHeader class") }
                return header


            default:
                return UICollectionReusableView()
            }
        }
        dataSource.apply(recieveSnapShot(), animatingDifferences: false)
    }
    
    private func recieveSnapShot() -> NSDiffableDataSourceSnapshot<HomeStoreSectionsModel, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<HomeStoreSectionsModel, AnyHashable>()
        snapshot.appendSections([HomeStoreSectionsModel.selectCategory])
        snapshot.appendItems(CategoryItemModel.getValueSelectCategory())
        
        snapshot.appendSections([HomeStoreSectionsModel.hotSales])
        snapshot.appendItems(CategoryItemModel.getValueShopSales())
        
        snapshot.appendSections([HomeStoreSectionsModel.bestSeller])
        snapshot.appendItems(CategoryItemModel.getValueBestSeller())
        
        return snapshot
    }
}
