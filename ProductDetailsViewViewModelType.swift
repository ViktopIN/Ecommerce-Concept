//
//  ProductDetailsViewViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 04.01.2023.
//

import UIKit

protocol ProductDetailsViewViewModelType: AnyObject {
    func amountOfMemotyButtonTap(firstButton: CustomButton,
                                 secondButton: CustomButton,
                                 sender: CustomButton)
    func colorTypeButtonTap(firstButton: CustomButton,
                            secondButton: CustomButton,
                            sender: CustomButton)
    func generateMainCollectionViewLayout() -> UICollectionViewLayout
    func fetchData(completion: @escaping () -> Void)
    func provideLoadingImageURL(indexPath: IndexPath) -> String?
    func numberOfItemsInSection() -> Int?
    func provideProductTitle() -> String?
    func fillSpecifications(cpuSpecication: UILabel,
                            cameraSpecification: UILabel,
                            ramSpecification: UILabel,
                            hddSpecification: UILabel,
                            within view: ProductSpecificationStackView)
    func provideColorsToColorTypeButtons(first: CustomButton,
                                         second: CustomButton)
    func provideMemoryAmounts(first: CustomButton,
                              second: CustomButton)
    func provideToAddToCartButtonText(button: CustomButton)
}
