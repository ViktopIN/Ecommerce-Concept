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
    
    let placeholderView = UIView(background: .darkGray)
    
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
        addSubview(placeholderView)
    }
    
    private func setupLayout() {
        placeholderView.fillSuperview()
    }
    
    private func setupView() {
        
    }
}

