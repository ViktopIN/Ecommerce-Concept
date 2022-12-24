//
//  HomeStoreViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit

class HomeStoreViewModel: HomeStoreViewModelType {
        
    // MARK: - Properties
    var homeStoreNetworkManager: NetworkManager = NetworkManager(url: URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")!)

    var homeStoreSections = HomeStoreSectionsModel.allCases
    var categoryItems: [AnyHashable] = CategoryItemModel.getValueSelectCategory()
    var hotSalesItems: [AnyHashable] = []
    var bestSellerItems: [AnyHashable] = []
    
    var selectedCategorySelectedIndexPath: IndexPath = [0, 0]

    // Methods
    
    func fetchData(completion: @escaping () -> Void) {
        homeStoreNetworkManager.getData { (networkModel: MainNetworkModel) in

            self.hotSalesItems = networkModel.homeStore
            self.bestSellerItems = networkModel.bestSeller
        }
    }
    func selectCategoryCellViewModel(indexPath: IndexPath) -> SelectCategoryCellViewModelType {
        if indexPath.item == 0 {
            var model = categoryItems[indexPath.item] as! CategoryItemModel
            model.isSelected = true
            return SelectCategoryCellViewModel(selectCategoryModel: model)
        } else {
            let model = categoryItems[indexPath.item] as! CategoryItemModel
            return SelectCategoryCellViewModel(selectCategoryModel: model)
        }
    }
    
    func hotSalesCellViewModel(indexPath: IndexPath) -> HotSalesCellViewModelType {
        let model = hotSalesItems[indexPath.item] as! HotSalesModel
        return HotSalesCellViewModel(model: model)
    }
    
    func bestSellerCellViewModel(indexPath: IndexPath) -> BestSellerCellViewModelType {
        let model = bestSellerItems[indexPath.item] as! BestSellerModel
        return BestSellerCellViewModel(bestSellerModel: model)
    }
    
    func selectItemHighlighting(collectionView: UICollectionView,
                                indexPath: IndexPath) {
        guard homeStoreSections[indexPath.section] == .selectCategory else { return }
        if indexPath != selectedCategorySelectedIndexPath {
            let cell = collectionView.cellForItem(at: indexPath) as! SelectCategoryCell
            var model = categoryItems[indexPath.item] as! CategoryItemModel
            model.isSelected = true
            cell.modelView = SelectCategoryCellViewModel(selectCategoryModel: model)
            let unhighlightedCell = collectionView.cellForItem(at: selectedCategorySelectedIndexPath) as! SelectCategoryCell
            let unhighlightedmodel = categoryItems[selectedCategorySelectedIndexPath.item] as! CategoryItemModel
            unhighlightedCell.modelView = SelectCategoryCellViewModel(selectCategoryModel: unhighlightedmodel)
            selectedCategorySelectedIndexPath = indexPath
        }
    }

    
    /// CollectionView dataSource drovider
    func collectionViewDataSourceProvider(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<HomeStoreSectionsModel, AnyHashable> {
        let dataSource = UICollectionViewDiffableDataSource<HomeStoreSectionsModel, AnyHashable>(collectionView: collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             itemIdentifier: AnyHashable) -> UICollectionViewCell? in
            let section = self.homeStoreSections[indexPath.section]
            switch section {
            case .selectCategory:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.reuseID, for: indexPath) as? SelectCategoryCell else { fatalError("change SelectCategoryCell class") }
                cell.modelView = self.selectCategoryCellViewModel(indexPath: indexPath)
                return cell
            case .hotSales:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCell.reuseID, for: indexPath) as? HotSalesCell else { fatalError("change HotSalesCell class") }
                cell.modelView = self.hotSalesCellViewModel(indexPath: indexPath)
                return cell
            case .bestSeller:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCell.reuseID, for: indexPath) as? BestSellerCell else { fatalError("change HotSalesCell class") }
                cell.modelView = self.bestSellerCellViewModel(indexPath: indexPath)
                
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
        return dataSource
    }
    
    private func recieveSnapShot() -> NSDiffableDataSourceSnapshot<HomeStoreSectionsModel, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<HomeStoreSectionsModel, AnyHashable>()
        snapshot.appendSections([homeStoreSections[0]])
        snapshot.appendItems(CategoryItemModel.getValueSelectCategory())
        
        snapshot.appendSections([homeStoreSections[1]])
        snapshot.appendItems(CategoryItemModel.getValueShopSales())
        
        snapshot.appendSections([homeStoreSections[2]])
        snapshot.appendItems(bestSellerItems)
        
        return snapshot
    }
    
    /// CollectionView layout providers
    func collectionViewLayoutProvider() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionIdentifier = self.homeStoreSections[sectionIndex]
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
        let categoryItemsCount = CGFloat(categoryItems.count)
        let groupWidth = Metrics.selectCategoryItemWidth * 5 + (5 * Metrics.spacingBetweenItemsInCategory)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth),
                                               heightDimension: .fractionalHeight(12/100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                            subitems: [item])
        group.contentInsets = Metrics.selectCategoryGroupInsets
        group.interItemSpacing = .fixed(Metrics.spacingBetweenItemsInCategory)
        
        // Header & footer
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1/12))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: SelectCategoryHeader.sectionHeader,
                                                                 alignment: .top)
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
                                                heightDimension: .fractionalHeight(1/23))
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
                                                heightDimension: .fractionalHeight(1/23))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: BestSellerHeader.sectionHeader,
                                                                 alignment: .top)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = Metrics.bestSellerSectionInsets

        return section
    }
    
    /// Views configure
    func makeAttributedText(with image: UIImage,
                            text: String,
                            textAttributes: [NSAttributedString.Key: Any]?,
                            textIsFirst boolProperty: Bool) -> NSAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        let completeText = NSMutableAttributedString(string: "")
        let text = NSAttributedString(string: text, attributes: textAttributes)
        let space = NSAttributedString(string: "  ")
        let attachmentImage = NSAttributedString(attachment: imageAttachment)
        
        if boolProperty {
            completeText.append(text)
            completeText.append(space)
            completeText.append(attachmentImage)
        } else {
            completeText.append(attachmentImage)
            completeText.append(space)
            completeText.append(text)
        }
        return completeText
    }
}

extension HomeStoreViewModel {
    enum Metrics {
        static let selectCategoryItemWidth: CGFloat = 71
        static let spacingBetweenItemsInCategory: CGFloat = 23
        static let selectCategoryGroupInsets = NSDirectionalEdgeInsets(top: 7,
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
                                                                     bottom: 50,
                                                                     trailing: 21)
        static let bestSellerItemInsets = NSDirectionalEdgeInsets(top: 7,
                                                                  leading: 6,
                                                                  bottom: 7,
                                                                  trailing: 6)
    }
}

