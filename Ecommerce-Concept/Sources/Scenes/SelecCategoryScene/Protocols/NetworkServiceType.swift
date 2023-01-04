//
//  NetworkServiceType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 21.12.2022.
//

import UIKit

protocol NetworkServiceType: AnyObject {
    static var shared: Self { get }
    func getData()
}
