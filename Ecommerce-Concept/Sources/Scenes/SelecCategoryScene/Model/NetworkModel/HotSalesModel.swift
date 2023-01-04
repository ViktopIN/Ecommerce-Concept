//
//  HotSalesModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 21.12.2022.
//

import Foundation

struct HotSalesModel: Decodable, Hashable {
    var id: Int
    var isNew: Bool?
    var title: String
    var subtitle: String
    var picture: String
    var isBuy: Bool
    
    enum HotSalesModel: String, CodingKey {
        case id
        case isNew = "is_new"
        case title
        case subtitle
        case picture
        case isBuy = "is_buy"
    }
}
