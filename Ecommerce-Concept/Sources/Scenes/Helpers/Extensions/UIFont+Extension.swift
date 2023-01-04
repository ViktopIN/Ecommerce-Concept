//
//  UIFont+Extension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UIFont

extension UIFont {
    static func markProHeavy(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "MarkPro-Heavy", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
    static func markProBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "MarkPro-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
    static func markProMedium(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "MarkPro-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
    static func markProRegular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "MarkPro-Regular", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }
}
