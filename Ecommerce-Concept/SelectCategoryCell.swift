//
//  SelectCategoryCell.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit

class SelectCategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "SelectCategoryCell"
    
    //  MARK: - Views
    
    let placeholderView = UIView(background: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
    
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
