//
//  UIView+Extension.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit

extension UIView {
    
    // MARK: - Init
    
    convenience init(background color: UIColor,
                     cornerType: CornerType = .none) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        guard cornerType == .rounded else { return }
        layer.cornerRadius = 30
        layer.masksToBounds = true
    }
    
    // MARK: - Methods
    
    func addSubviews(_ views: UIView...) {
        views.forEach{ self.addSubview($0) }
    }
    
    func fillSuperview(with insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        NSLayoutConstraint.activate(
            [self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)]
        )
    }
}

extension UIView {
    enum CornerType {
        case none, rounded
    }
}
