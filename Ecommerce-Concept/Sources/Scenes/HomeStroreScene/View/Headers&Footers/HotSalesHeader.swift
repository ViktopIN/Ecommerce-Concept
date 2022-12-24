//
//  HotSalesHeader.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit

class HotSalesHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let sectionHeader = "hotSales-section-header-element-kind"
    static let reuseID = "HotSalesHeader"
    
    //  MARK: - Views
    
    private lazy var hotSalesTitleLabel = UILabel(constant: Strings.hotSalesTitleConstantText,
                                                        with: Metrics.hotSalesTitleLabelTextSize,
                                                        and: .bold, UIColor.customDarkBlue)
    private lazy var seeMoreButton = UIButton(title: Strings.seeMoreButtonTitleConstantText,
                                              and: UIColor.customOrange,
                                              font: UIFont.markProRegular(ofSize: Metrics.seeMoreButtonTitleTextSize))
    
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubviews(hotSalesTitleLabel, seeMoreButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            hotSalesTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/4),
            hotSalesTitleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            hotSalesTitleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            hotSalesTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)

        ])
        
        NSLayoutConstraint.activate([
            seeMoreButton.widthAnchor.constraint(equalToConstant: Metrics.seeMoreButtonWidth),
            seeMoreButton.heightAnchor.constraint(equalToConstant: Metrics.seeMoreButtonHeight),
            seeMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeMoreButton.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

extension HotSalesHeader {
    enum Metrics {
        static let hotSalesTitleLabelTextSize: CGFloat = 25
        static let seeMoreButtonTitleTextSize: CGFloat = 15
        static let seeMoreButtonWidth: CGFloat = 70
        static let seeMoreButtonHeight: CGFloat = 19
    }
    
    enum Strings {
        static let hotSalesTitleConstantText = "Hot Sales"
        static let seeMoreButtonTitleConstantText = "see more"
    }
}


