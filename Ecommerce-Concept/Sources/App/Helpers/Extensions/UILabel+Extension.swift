//
//  UILabel+Extension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UILabel

extension UILabel {
    enum MarkProFonts {
        case heavy, bold, medium, regular
    }
    convenience init(constant text: String = "",
                     with textSize: CGFloat,
                     and markProFontType: MarkProFonts,
                     _ fontColor: UIColor = .black,
                     adjustFontSizeToFit: Bool = false) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.textColor = fontColor
        self.adjustsFontSizeToFitWidth = adjustFontSizeToFit
        switch markProFontType {
        case .heavy:
            self.font = UIFont.markProHeavy(ofSize: textSize)
        case .bold:
            self.font = UIFont.markProBold(ofSize: textSize)
        case .medium:
            self.font = UIFont.markProMedium(ofSize: textSize)
        case .regular:
            self.font = UIFont.markProRegular(ofSize: textSize)
        }
    }
}
