//
//  BottomSheetFilterViewViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 28.12.2022.
//

import UIKit

protocol BottomSheetFilterViewViewModelType: AnyObject {
    var cellConstantModels: [String : [String]] { get }
    func configure(cell: UITableViewCell,
                   with indexPath: IndexPath)
    func configure(header: UITableViewHeaderFooterView,
                   with sectionNumber: Int)
    func selectRowFunctionality(cell: UITableViewCell,
                                indexPath: IndexPath) -> UIAlertController
}
