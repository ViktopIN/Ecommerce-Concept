//
//  FilterParametersTableViewHeader.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 26.12.2022.
//

import UIKit

class FilterParametersTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    
    static let reuseID = "FilterParametersTableViewHeader"
    
    // MARK: - Views
    
    private lazy var mainHeaderLabel = UILabel(with: 18,
                                               and: .medium)
    
    // MARK: - Initialse
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubview(mainHeaderLabel)
    }
    
    private func setupLayout() {
        mainHeaderLabel.fillSuperview()
    }
    
    private func setupView() {
        mainHeaderLabel.textAlignment = .left
    }
    
    // MARK: - Method
    
    func configureHeader(with text: String) {
        mainHeaderLabel.text = text
    }
}
