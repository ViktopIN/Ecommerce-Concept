//
//  File.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UIImageView

extension UIImageView {
    convenience init(baseImage: UIImage?,
                     with color: UIColor) {
        self.init()
        self.image = baseImage?.withTintColor(color, renderingMode: .alwaysOriginal)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .center
    }
}
