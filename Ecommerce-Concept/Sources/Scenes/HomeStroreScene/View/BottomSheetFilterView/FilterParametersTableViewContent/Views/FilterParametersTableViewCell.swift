//
//  FilterParametersTableViewCell.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 26.12.2022.
//

import UIKit

class FilterParametersTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "FilterParametersTableViewCell"
    
    // MARK: - Views
    
    private lazy var mainLabel = UILabel(with: Metrics.mainLabelTextSize,
                                         and: .regular,
                                         .customDarkBlue)
    private lazy var mainImageView = UIImageView(baseImage: UIImage(systemName: "chevron.down"),
                                                 with: .lightGray)
    
    // MARK: - Initialise
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
        addSubviews(mainLabel, mainImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.mainLabelLayoutMargins.top),
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.mainLabelLayoutMargins.bottom),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.mainLabelLayoutMargins.left),
            mainLabel.trailingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: -Metrics.mainLabelLayoutMargins.right)
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.mainImageViewLayoutMargins.top),
            mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.mainImageViewLayoutMargins.bottom),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.mainImageViewLayoutMargins.right),
            mainImageView.widthAnchor.constraint(equalToConstant: Metrics.mainImageViewWidth)
        ])

    }
    
    private func setupView() {
        // Label setup
        mainLabel.textAlignment = .left
                
        // Cell Setup
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        
        // Cell cornerRadius
        contentView.layer.cornerRadius = 5
    }
    
    // MARK: - Method
    
    func configureCell(with string: String) {
        mainLabel.text = string
    }
    
}

extension FilterParametersTableViewCell {
    enum Metrics {
        static let mainLabelTextSize: CGFloat = 18
        static let mainLabelLayoutMargins = UIEdgeInsets(top: 7,
                                                         left: 14,
                                                         bottom: 7,
                                                         right: 7)
        static let mainImageViewWidth: CGFloat = 43
        static let mainImageViewLayoutMargins = UIEdgeInsets(top: 15,
                                                             left: 5,
                                                             bottom: 14,
                                                             right: 20)

    }
}
