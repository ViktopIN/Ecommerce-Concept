//
//  ProductDetailsViewController.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 04.01.2023.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: Coordinator!
    
    // MARK: - Views
    
    private lazy var titleStackView = UIStackView(with: .horizontal,
                                                  distribution: .fill,
                                                  spacing: Metrics.titleStackViewSpacing)
    
    private lazy var backButton = CustomButton(internalObject: UIImage(named: "left-shield")!,
                                               objectColor: .white,
                                               backgroundView: .roundedCorner(color: .customDarkBlue))
    private lazy var titleLabel = UILabel(constant: Strings.titleLabelText,
                                          with: Metrics.titleLabelTextSize,
                                          and: .medium,
                                          .customDarkBlue)
    private lazy var cartButton = CustomButton(internalObject: UIImage(named: "mini-cart")!,
                                               objectColor: .white,
                                               backgroundView: .roundedCorner(color: .customOrange))
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubviews(titleStackView)
        titleStackView.addArrangedSubviews(backButton,
                                           titleLabel,
                                           cartButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.titleStackViewTopInset),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.titleStackViewLeadingInset),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Metrics.titleStackViewTrailingInset),
        ])
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: Metrics.titleButtonHeight),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.titleButtonHeight)
        ])
        NSLayoutConstraint.activate([
            cartButton.heightAnchor.constraint(equalToConstant: Metrics.titleButtonHeight),
            cartButton.widthAnchor.constraint(equalToConstant: Metrics.titleButtonHeight)
        ])
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        
        // backButton action
        backButton.addTarget(self,
                             action: #selector(returnToHomeStore), 
                             for: .touchUpInside)
    }
    
    @objc
    func returnToHomeStore() {
        coordinator.showHomeStoreView()
    }

}

// MARK: - Metrics extension

extension ProductDetailsViewController {
    enum Metrics {
        static let titleStackViewSpacing: CGFloat = 51
        static let titleStackViewTopInset: CGFloat = 79
        static let titleStackViewLeadingInset: CGFloat = 42
        static let titleStackViewTrailingInset: CGFloat = -35
        static let titleButtonHeight: CGFloat = 37
        static let titleLabelTextSize: CGFloat = 18
        static let titleLabelWidth: CGFloat = 173
    }
    
    enum Strings {
        static let titleLabelText = "Product Details"
    }
}
