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
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: generateCollectionViewLayout())
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
        viewModel = HomeStoreViewModel()
        dataSourceConfigure()
    }
}

// MARK: - Extensions

extension HomeStoreControllerView {
    
    // MARK: - CollectionView configure
    
    private func dataSourceConfigure() {
        dataSource = viewModel.collectionViewDataSourceProvider(collectionView: collectionView)
    }
    
    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        viewModel.collectionViewLayoutProvider()
    }
}
