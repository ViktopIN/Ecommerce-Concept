//
//  Int+Extension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 19.12.2022.
//

import Foundation

extension Int {
    var withDollar: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return (formatter.string(for: self) ?? "0") + " \u{0024}"
    }
}
