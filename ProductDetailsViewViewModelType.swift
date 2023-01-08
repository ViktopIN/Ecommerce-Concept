//
//  ProductDetailsViewViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 04.01.2023.
//

import UIKit

protocol ProductDetailsViewViewModelType: AnyObject {
    func generateMainCollectionViewLayout() -> UICollectionViewLayout
    func fetchData(completion: @escaping () -> Void)
    func provideLoadingImageURL(indexPath: IndexPath) -> String?
    func numberOfItemsInSection() -> Int?
    func provideProductTitle() -> String?
}
