//
//  CollectionViewDataSourceConfigureType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 18.12.2022.
//

import UIKit

protocol CollectionViewDataSourceConfigureType {
    associatedtype Section: Hashable
    associatedtype Item: Hashable
    func recieveSnapShot() -> NSDiffableDataSourceSnapshot<Section, Item>
}


