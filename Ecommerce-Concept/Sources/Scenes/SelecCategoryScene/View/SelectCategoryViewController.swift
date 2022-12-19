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
        viewModel = SelectCategoryViewViewModel()
        collectionView = collectionViewConfigure()
        dataSourceConfigure()
    }
}

// MARK: - Extensions

extension SelectCategoryViewController {
    
    /// Data source configure
    private func dataSourceConfigure() {
        dataSource = UICollectionViewDiffableDataSource<Sections, ItemModel>(collectionView: self.collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             itemIdentifier: ItemModel) -> UICollectionViewCell? in
            return self.viewModel.cellViewModel.recieveCellView(with: indexPath,
                                                                in: collectionView,
                                                                itemIdentifier: itemIdentifier)
        }
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView,
                                                  elementKind: String,
                                                  indexPath: IndexPath) -> UICollectionReusableView? in
            return self.viewModel.reusableViewModel.recieveHeaderFooterView(with: indexPath,
                                                                            elementKind: elementKind,
                                                                            in: collectionView)
        }
        dataSource.apply(viewModel.collectionViewDataSourceConfigure.recieveSnapShot(), animatingDifferences: false)
    }
    
    /// CollectionView Configure
    func collectionViewConfigure() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: viewModel.collectionViewViewModel.generateCollectionViewLayout())
        collectionView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
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
        
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
}

extension SelectCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        viewModel.cellViewModel.changeItemColorForSelectCategoryGroup(in: indexPath,
                                                                      collectionView: collectionView,
                                                                      dataSource: dataSource)
    }
}
