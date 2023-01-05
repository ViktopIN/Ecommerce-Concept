//
//  SelectCategoryCellViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit.UIImage

protocol SelectCategoryCellViewModelType: AnyObject {
    var selectCategoryModel: CategoryItemModel { get set }
    var image: UIImage { get }
    var title: String { get }
    var viewColor: UIColor? { get }
    var textColor: UIColor? { get }
    var isSelected: Bool { get }
}
