//
//  HotSalesCellViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 24.12.2022.
//

import UIKit

class HotSalesCellViewModel: HotSalesCellViewModelType {
    
    // MARK: - Properties
    
    var model: HotSalesModel
    
    var id: Int {
        model.id
    }
    
    var isNew: Bool {
        model.isNew ?? false
    }
    
    var title: String {
        model.title
    }
    
    var subtitle: String {
        model.subtitle
    }
    
    var picture: UIImage {
        let data = try! Data(contentsOf: URL(string: model.picture)!)
        let image = UIImage(data: data) ?? UIImage()
        return image
    }
    
    var isNotBuy: Bool {
        !(model.isBuy)
    }
    
    // MARK: - Initialise
    
    init(model: HotSalesModel) {
        self.model = model
    }
}
