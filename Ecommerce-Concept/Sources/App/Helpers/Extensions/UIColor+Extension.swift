//
//  UIColor+Extension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit.UIColor

extension UIColor {
    static let customOrange: UIColor = #colorLiteral(red: 1, green: 0.5189241767, blue: 0.3763272166, alpha: 1)
    static let customDarkBlue: UIColor = #colorLiteral(red: 0.003921568627, green: 0, blue: 0.2078431373, alpha: 1)
    
    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                 blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }
}
