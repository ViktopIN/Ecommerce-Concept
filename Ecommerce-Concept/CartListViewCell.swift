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
    
    private lazy var bottomSeparetedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        return imageView
    }()
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
    private lazy var editAmountStepper = EditModelAmountStepper(frame: .zero)
    private lazy var deleteButton = CustomButton(internalObject: UIImage(named: "bin"),
                                                 objectColor: UIColor(red: 0.213, green: 0.211, blue: 0.3, alpha: 1),
                                                 backgroundView: .none)
    
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
        mainImageView.addSubview(activityIndicatorPlaceholder)
        addSubviews(bottomSeparetedView,
                    mainImageView,
                    infoParentStack,
                    editAmountStepper,
                    deleteButton)
        infoParentStack.addArrangedSubviews(productNameLabel, productCostLabel)
    }
    
    private func setupLayout() {
        
        // activityIndicatorPlaceholder constraints
        activityIndicatorPlaceholder.fillSuperview()
        
        NSLayoutConstraint.activate([
            // bottomSeparetedView constraint
            bottomSeparetedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparetedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparetedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparetedView.heightAnchor.constraint(equalToConstant: Metrics.bottomSeparetedViewHeight),
            
            // MainImageView Constraints
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.mainImageViewLeadingInset),
            mainImageView.widthAnchor.constraint(equalToConstant: Metrics.mainImageViewWidth),
            mainImageView.bottomAnchor.constraint(equalTo: bottomSeparetedView.topAnchor),
            
            // infoParentStack constraints
            infoParentStack.topAnchor.constraint(equalTo: topAnchor),
            infoParentStack.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: Metrics.infoParentStackLeadingInset),
            infoParentStack.bottomAnchor.constraint(equalTo: bottomSeparetedView.topAnchor),
            infoParentStack.widthAnchor.constraint(equalToConstant: Metrics.infoParentStackWidth),
            
            // editAmountStepper constraints
            editAmountStepper.leadingAnchor.constraint(equalTo: infoParentStack.trailingAnchor, constant: Metrics.editAmountStepperLeadingInset),
            editAmountStepper.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            editAmountStepper.widthAnchor.constraint(equalToConstant: Metrics.editAmountStepperWidth),
            editAmountStepper.heightAnchor.constraint(equalToConstant: Metrics.editAmountStepperHeight),
            
            // deleteButton constraints
            deleteButton.leadingAnchor.constraint(equalTo: editAmountStepper.trailingAnchor, constant: Metrics.deleteButtonLeadingInset),
            deleteButton.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: Metrics.deleteButtonHeight),
            deleteButton.widthAnchor.constraint(equalToConstant: Metrics.deleteButtonWidth)
        ])
    }
    
    private func setupView() {
        // view setup
        backgroundColor = .clear
        
        // productNameLabel setup
        productNameLabel.numberOfLines = 0
    }
}

// MARK: - Extension

extension CartListViewCell {
    enum Metrics {
        static let bottomSeparetedViewHeight: CGFloat = 45
        
        static let mainImageViewLeadingInset: CGFloat = 13
        static let mainImageViewWidth: CGFloat = 85
        
        static let infoParentStackSpacing: CGFloat = 6
        static let infoParentStackLeadingInset: CGFloat = 20
        static let infoParentStackWidth: CGFloat = 153
        
        static let editAmountStepperLeadingInset: CGFloat = 25
        static let editAmountStepperWidth: CGFloat = 26
        static let editAmountStepperHeight: CGFloat = 75
        
        static let deleteButtonLeadingInset: CGFloat = 12
        static let deleteButtonHeight: CGFloat = 15
        static let deleteButtonWidth: CGFloat = 17

        static let labelsTextSize: CGFloat = 20
    }
    
    enum Strings {
        static let productNameLabelTextPlaceholder = "Unknown model"
        static let productCostLabelTextPlaceholder = "Unknown cost"
    }
}
