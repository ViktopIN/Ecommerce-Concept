//
//  CoordinatorProtocol.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 25.12.2022.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
    func showHomeStoreView()
    func showBottomSheetOnHomeStoreView()
}
