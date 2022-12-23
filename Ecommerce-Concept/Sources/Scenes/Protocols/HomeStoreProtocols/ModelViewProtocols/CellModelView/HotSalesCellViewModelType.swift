//
//  HotSalesCellViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import Foundation

protocol HotSalesCellViewModelType {
    var id: Int { get set }
    var isNew: Bool { get set }
    var title: String { get set }
    var subtitle: String { get set }
    var picture: String { get set }
}


