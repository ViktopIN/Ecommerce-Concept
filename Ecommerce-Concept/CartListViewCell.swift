//
//  CartListViewCell.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 09.01.2023.
//

import UIKit

final class CartListViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "CartListViewCell"
    
    // MARK: - Views
    
    private lazy var mainImageView = UIImageView(background: .white,
                                                 cornerType: .rounded)
    private lazy var activityIndicatorPlaceholder: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    private lazy var infoParentStack = UIStackView(with: .vertical,
                                                   spacing: Metrics.infoParentStackSpacing)
    private lazy var productNameLabel = UILabel(constant: Strings.productNameLabelTextPlaceholder,
                                                with: Metrics.labelsTextSize,
                                                and: .medium,
                                                .white)
    private lazy var productCostLabel = UILabel(constant: Strings.productCostLabelTextPlaceholder,
                                                with: Metrics.labelsTextSize,
                                                and: .medium,
                                                .customOrange)
    
    
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    private func setupView() {
        // productNameLabel setup
        productNameLabel.numberOfLines = 0
    }
}

// MARK: - Extension

extension CartListViewCell {
    enum Metrics {
        static let infoParentStackSpacing: CGFloat = 6
        
        static let labelsTextSize: CGFloat = 20
    }
    
    enum Strings {
        static let productNameLabelTextPlaceholder = "Unknown model"
        static let productCostLabelTextPlaceholder = "Unknown cost"
    }
}
