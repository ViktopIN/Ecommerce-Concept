//
//  UIButton+Extension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UIButton

extension UIButton {
    convenience init(title text: String,
                     and color: UIColor,
                     font: UIFont) {
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = font
    }
}

