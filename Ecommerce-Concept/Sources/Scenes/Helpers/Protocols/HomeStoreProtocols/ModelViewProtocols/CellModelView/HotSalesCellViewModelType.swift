//
//  HotSalesCellViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 23.12.2022.
//

import UIKit.UIImage

protocol HotSalesCellViewModelType: AnyObject {
    var id: Int { get }
    var isNew: Bool { get }
    var title: String { get }
    var subtitle: String { get }
    var picture: UIImage { get }
    var isNotBuy: Bool { get }
    var model: HotSalesModel { get set }
}


