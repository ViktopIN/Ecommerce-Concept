//
//  EditModelAmountStepper.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 09.01.2023.
//

import UIKit

final class EditModelAmountStepper: UIStackView {

    // MARK: - Views
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "minus"), for: .normal)
        return button
    }()
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    private lazy var countLabel = UILabel(constant: "0",
                                          with: 20,
                                          and: .medium,
                                          .white)
    
    // MARK: - Initialise
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addArrangedSubviews(minusButton,
                            countLabel,
                            plusButton)
    }
    
    private func setupLayout() {
        
    }
    
    private func setupView() {
        // stackView setup
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 6
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 8,
                                     left: 8,
                                     bottom: 8,
                                     right: 8)
        backgroundColor = UIColor(red: 0.158, green: 0.156, blue: 0.262, alpha: 1)
        layer.cornerRadius = 26
    }
}
