//
//  ProductDetailData.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 05.01.2023.
//

import Foundation

// MARK: - ProductDetailData
struct ProductDetailData: Codable {
    let cpu, camera: String
    let capacity, color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd, ssd, title: String

    enum CodingKeys: String, CodingKey {
        case cpu = "CPU"
        case camera, capacity, color, id, images, isFavorites, price, rating, sd, ssd, title
    }
}
