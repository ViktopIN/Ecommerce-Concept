//
//  SelectCategoryViewController.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 08.12.2022.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: SelectCategoryViewViewModel!
    
    // MARK: - Views
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Sections, ItemModel>! = nil
    private lazy var collectionView: UICollectionView! = nil
    
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
        viewModel = modelViewConfigure() as? SelectCategoryViewViewModel
        collectionView = collectionViewConfigure()
        dataSourceConfigure()
    }
}

// MARK: - Extensions

/// ViewModel configure
extension SelectCategoryViewController {
    private func modelViewConfigure() -> some SelectCategoryViewViewModelType {
        return SelectCategoryViewViewModel()
    }
}

extension SelectCategoryViewController {
    
    /// Data source configure
    private func dataSourceConfigure() {
        dataSource = UICollectionViewDiffableDataSource<Sections, ItemModel>(collectionView: self.collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             itemIdentifier: ItemModel) -> UICollectionViewCell? in
            return self.viewModel.recieveCellView(with: indexPath, in: collectionView)
        }
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView,
                                                  elementKind: String,
                                                  indexPath: IndexPath) -> UICollectionReusableView? in
            return self.viewModel.recieveHeaderFooterView(with: indexPath,
                                                          elementKind: elementKind,
                                                          in: collectionView)
        }
        dataSource.apply(viewModel.recieveSnapShot(), animatingDifferences: false)
    }
    
    /// CollectionView Configure
    func collectionViewConfigure() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: viewModel.generateCollectionViewLayout())
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
    }

}
