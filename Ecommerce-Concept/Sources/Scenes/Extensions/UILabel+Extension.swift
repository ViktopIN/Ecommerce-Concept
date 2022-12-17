//
//  UILabel+Extension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UILabel

extension UILabel {
    convenience init(with textSize: CGFloat,
                     and textWeight: UIFont.Weight,
                     _ fontColor: UIColor = .black) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        self.textColor = fontColor
        self.font = UIFont.systemFont(ofSize: textSize, weight: textWeight)
    }
}
