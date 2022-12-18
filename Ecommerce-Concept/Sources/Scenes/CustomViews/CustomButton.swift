//
//  CustomButton.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UIButton

class CustomButton: UIButton {
    
    // MARK: - Initialise

    init(internalImage: UIImage?,
         imageColor: UIColor?,
         backgroundView: BackgroundViewStyle) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.setImage(internalImage?.withTintColor(imageColor ?? .clear,
                                                   renderingMode: .alwaysOriginal), for: .normal)
        self.imageView?.contentMode = .center
        switch backgroundView {
        case .circle(let color, let buttonHeight):
            layer.masksToBounds = true
            layer.cornerRadius = buttonHeight / 2
            layer.backgroundColor = color.cgColor
        case .roundedCorner(let color):
            layer.masksToBounds = true
            layer.backgroundColor = color.cgColor
            layer.cornerRadius = 10
        case .none:
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButton {
    enum BackgroundViewStyle {
        case circle(color: UIColor, buttonHeight: CGFloat)
        case roundedCorner(color: UIColor)
        case none
    }
}
