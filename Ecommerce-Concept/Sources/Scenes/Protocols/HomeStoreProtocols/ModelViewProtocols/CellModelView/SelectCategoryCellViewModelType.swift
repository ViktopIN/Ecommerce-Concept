//
//  SelectCategoryCellViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit.UIImage

protocol SelectCategoryCellViewModelType {
    var image: UIImage { get set }
    var title: String { get set }
    var isSelected: Bool { get set }
}
