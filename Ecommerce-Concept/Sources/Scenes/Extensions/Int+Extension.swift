//
//  Int+Extension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 19.12.2022.
//

import Foundation

extension Int {
    var withDollar: String {
        String(self) + " \u{0024}"
    }
}
