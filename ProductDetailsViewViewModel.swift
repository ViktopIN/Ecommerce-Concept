//
//  ProductDetailsViewViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 04.01.2023.
//

import UIKit

final class ProductDetailsViewViewModel: ProductDetailsViewViewModelType {
    func numberOfItemsInSection() -> Int? {
        productDetailData?.images.count
    }
    
    
    // MARK: - Properties
    
    var productDetailData: ProductDetailData?
    private var networkManager = NetworkManager(url: URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"))
    
    // MARK: - Methods
    
    func generateMainCollectionViewLayout() -> UICollectionViewLayout {
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(266),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                        leading: 0,
                                                        bottom: 13,
                                                        trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func fetchData(completion: @escaping () -> Void) {
        networkManager.getData2 { (productDetailData: ProductDetailData) in
            self.productDetailData = productDetailData
            completion()
        }
    }
    
    func provideLoadingImageURL(indexPath: IndexPath) -> String? {
        productDetailData?.images[indexPath.item]
    }
    
    func provideProductTitle() -> String? {
        productDetailData?.title
    }
    
    func numberOfItemsInSection() -> Int? {
        productDetailData?.images.count
    }
}
