//
//  HotSalesModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 21.12.2022.
//

import Foundation

struct HotSalesModel: Decodable {
    var isNew: Bool
    var title: String
    var subtitle: String
    var picture: String
    var isBuy: Bool
}
