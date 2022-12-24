//
//  BestSellerHeader.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit

class BestSellerHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let sectionHeader = "bestSeller-section-header-element-kind"
    static let reuseID = "BestSellerHeader"
    
    //  MARK: - Views
    
    
    private lazy var bestSellerTitleLabel = UILabel(constant: Strings.bestSellerTitleConstantText,
                                                        with: Metrics.bestSellerTitleLabelTextSize,
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
        addSubviews(bestSellerTitleLabel, seeMoreButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            bestSellerTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/4),
            bestSellerTitleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            bestSellerTitleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            bestSellerTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)

        ])
        
        NSLayoutConstraint.activate([
            seeMoreButton.widthAnchor.constraint(equalToConstant: Metrics.seeMoreButtonWidth),
            seeMoreButton.heightAnchor.constraint(equalToConstant: Metrics.seeMoreButtonHeight),
            seeMoreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeMoreButton.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}


extension BestSellerHeader {
    enum Metrics {
        static let bestSellerTitleLabelTextSize: CGFloat = 25
        static let seeMoreButtonTitleTextSize: CGFloat = 15
        static let seeMoreButtonWidth: CGFloat = 70
        static let seeMoreButtonHeight: CGFloat = 19
    }
    
    enum Strings {
        static let bestSellerTitleConstantText = "Best Seller"
        static let seeMoreButtonTitleConstantText = "see more"
    }
}
