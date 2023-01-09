//
//  UIStackView+Exension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 17.12.2022.
//

import UIKit

extension UIStackView {
    convenience init(with axis: NSLayoutConstraint.Axis,
         distribution: UIStackView.Distribution = .fill,
         spacing: CGFloat = 0,
         layoutMargins: UIEdgeInsets = .zero) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        if layoutMargins != .zero {
            isLayoutMarginsRelativeArrangement = true
            self.layoutMargins = layoutMargins
        }
    }
    
    final func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }    
}
