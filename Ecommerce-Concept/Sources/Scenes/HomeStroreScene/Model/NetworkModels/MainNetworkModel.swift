//
//  MainNetworkModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import Foundation

struct MainNetworkModel: Decodable {
    var homeStore: [HotSalesModel]
    var bestSeller: [BestSellerModel]
}
