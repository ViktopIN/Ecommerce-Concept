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
         imageColor: UIColor,
         backgroundView: BackgroundViewStyle) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.setImage(internalImage?.withTintColor(imageColor,
                                                   renderingMode: .alwaysOriginal), for: .normal)
        self.imageView?.contentMode = .center
        switch backgroundView {
        case .circle(let color, let buttonHeight):
            layer.masksToBounds = true
            layer.backgroundColor = color.cgColor
            layer.cornerRadius = buttonHeight / 2
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
    
    // MARK: - Method
    
    static func createFavoriteButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "noFillHeart"),
                        for: .normal)
        button.setImage(UIImage(named: "fillHeart"),
                        for: .selected)
        button.backgroundColor = .white
        button.imageView?.contentMode = .center
        button.layer.cornerRadius = 25 / 2
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
        button.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0,
                                                                   y: 0,
                                                                   width: 25,
                                                                   height: 25),
                                               cornerRadius: 25/2).cgPath
        button.layer.shadowOffset = .zero
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}

extension CustomButton {
    enum BackgroundViewStyle {
        case circle(color: UIColor,
                    buttonHeight: CGFloat)
        case roundedCorner(color: UIColor)
        case none
    }
}
