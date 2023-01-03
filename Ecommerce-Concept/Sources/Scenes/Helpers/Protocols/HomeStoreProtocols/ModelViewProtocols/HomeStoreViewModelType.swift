//
//  HomeStoreViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit.UICollectionView

protocol HomeStoreViewModelType {
    
    // Properties
    
    var coordinator: Coordinator? { get set }
    
    // MakeAttributedWithImage Text (for ExplorerLabel)
    
    func makeAttributedText(with image: UIImage,
                            text: String,
                            textAttributes: [NSAttributedString.Key: Any]?,
                            textIsFirst boolProperty: Bool) -> NSAttributedString
    
    // Network manager and fetch data method
    var homeStoreNetworkManager: NetworkManager { get }
    func fetchData(completion: @escaping () -> Void)
    
    // Section model
    var homeStoreSections: [HomeStoreSectionsModel] { get }
    
    // Item models
    var categoryItems: [AnyHashable] { get set }
    var hotSalesItems: [AnyHashable] { get set }
    var bestSellerItems: [AnyHashable] { get set }
    
    // Cell viewModel providers
    func selectCategoryCellViewModel(indexPath: IndexPath) -> SelectCategoryCellViewModelType?
    func hotSalesCellViewModel(indexPath: IndexPath) -> HotSalesCellViewModelType? 
    func bestSellerCellViewModel(indexPath: IndexPath) -> BestSellerCellViewModelType?
        
    // CollectionView setups
    func collectionViewLayoutProvider() -> UICollectionViewLayout
    func collectionViewDataSourceProvider(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<HomeStoreSectionsModel, AnyHashable>
    func selectItemHighlighting(collectionView: UICollectionView,
                                indexPath: IndexPath)
}
