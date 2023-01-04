//
//  BottomSheetFilterViewViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 28.12.2022.
//

import UIKit

class BottomSheetFilterViewViewModel: BottomSheetFilterViewViewModelType {
    func selectRowFunctionality(cell: UITableViewCell,
                                indexPath: IndexPath) -> UIAlertController {
        let allertController = UIAlertController()
        guard let cell = cell as? FilterParametersTableViewCell else { fatalError() }
        addAlertActions(fromDictionary: cellConstantModels,
                        forKey: headerNames[indexPath.section],
                        to: allertController,
                        formatting: cell)
        return allertController
    }
    
    func configure(cell: UITableViewCell,
                   with indexPath: IndexPath) {
        guard let cell = cell as? FilterParametersTableViewCell else { return }
        cell.configureCell(with: cellConstantModels[headerNames[indexPath.section]]?[0] ?? "Brand")
    }
    
    func configure(header: UITableViewHeaderFooterView,
                   with sectionNumber: Int) {
        guard let header = header as? FilterParametersTableViewHeader else { return }
        header.configureHeader(with: headerNames[sectionNumber])
    }

    let cellConstantModels = ["Brand": ["Samsung", "Apple", "Xiaomi", "Honor"],
                              "Price": ["\(0.withDollar) - \(100.withDollar)",
                                        "\(100.withDollar) - \(300.withDollar)",
                                        "\(300.withDollar) - \(500.withDollar)",
                                        "\(500.withDollar) - \(1499.withDollar)",
                                        "\(1500.withDollar) - \(5000.withDollar)",
                                        "\(5000.withDollar) - \(10000.withDollar)"],
                              "Size": ["4.5 to 5.5 inches"]]
    private var headerNames = ["Brand", "Price", "Size"]
    
    private func addAlertActions(fromDictionary: [String: [String]],
                                 forKey: String,
                                 to allertController: UIAlertController,
                                 formatting cell: FilterParametersTableViewCell) {
        let array = fromDictionary[forKey] ?? []
        for i in array {
            allertController.addAction(UIAlertAction(title: i, style: .default) { _ in
                cell.configureCell(with: i)
            })
        }
        allertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    }
}
