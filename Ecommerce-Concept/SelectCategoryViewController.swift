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
    }
    
    // MARK: - Views
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateCollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.register(SelectCategoryCell.self,
                                forCellWithReuseIdentifier: SelectCategoryCell.reuseID)
        collectionView.register(SelectCategoryHeader.self,
                                forSupplementaryViewOfKind: Sections.selectCategory.rawValue,
                                withReuseIdentifier: SelectCategoryHeader.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    // MARK: - Settings
    
    private func setupHierarchy() {
        
        view.addSubviews(collectionView)
    }
    
    private func setupLayout() {
        
        collectionView.fillSuperview()
    }
    
    private func setupView() {
    
    }
}

// MARK: - Extensions

extension SelectCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - CollectionView configure
        
    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(Metrics.selectCategoryItemWidth),
                                                heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
        let groupWidth = Metrics.selectCategoryItemWidth * 15 + (15 * Metrics.spacingBetweenItemsInCategory)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth),
                                               heightDimension: .fractionalHeight(12/100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                            subitems: [item])
        group.contentInsets = Metrics.selectCategoryGroupInsets
        group.interItemSpacing = .fixed(Metrics.spacingBetweenItemsInCategory)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .fractionalHeight(1/10))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: Sections.selectCategory.rawValue,
                                                                 alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = Metrics.selectCategorySectionInsets

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // Delegate methods
    #warning("Delete that")
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.reuseID,
                                                      for: indexPath) as? SelectCategoryCell else {fatalError("change class name for select cells")}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: SelectCategoryHeader.reuseID,
                                                                     for: indexPath) as? SelectCategoryHeader else {fatalError("change class name for select header")}
        return header
    }
}
