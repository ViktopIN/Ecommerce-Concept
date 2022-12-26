//
//  SelectCategoryCellViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit

class SelectCategoryCellViewModel: SelectCategoryCellViewModelType {
            
    var selectCategoryModel: CategoryItemModel
    var image: UIImage {
        guard isSelected else {
            return selectCategoryModel.image.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        }
        return selectCategoryModel.image.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
    var title: String {
        return selectCategoryModel.name
    }
    var viewColor: UIColor? {
        guard isSelected else {
            return .white
        }
        return .customOrange
    }
    var textColor: UIColor? {
        guard isSelected else {
            return .customDarkBlue
        }
        return .customOrange
    }
    var isSelected: Bool {
        return selectCategoryModel.isSelected
    }
    
    // MARK: - Initialise
    
    init(selectCategoryModel: CategoryItemModel) {
        self.selectCategoryModel = selectCategoryModel
    }
}
