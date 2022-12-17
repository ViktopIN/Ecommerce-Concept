//
//  SelectCategoryHeader.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit

class SelectCategoryHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let sectionHeader = "selectCategory-section-header-element-kind"
    static let reuseID = "SelectCategoryHeader"
    
    //  MARK: - Views
        
    private lazy var parentStack = UIStackView(with: .vertical,
                                               spacing: Metrics.parentStackSpacing,
                                               layoutMargins: Metrics.parentStackLayoutMargin)
    private lazy var locationAndFilterView = UIView(background: .systemBackground)
    private lazy var titleView = UIView(background: .systemBackground)
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)
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
        
    }
}

extension SelectCategoryHeader {
    enum Metrics {
        static let parentStackSpacing: CGFloat = 18
        static let parentStackLayoutMargin = UIEdgeInsets(top: 0,
                                                          left: 17,
                                                          bottom: 0,
                                                          right: 33)
        
        static let locationStackSpacing: CGFloat = 11
    }
}

