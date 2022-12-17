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
                                               spacing: Metrics.parentStackSpacing)
    private lazy var locationAndFilterView = UIView(background: .systemBackground)
    private lazy var locationStackView = UIStackView(with: .horizontal,
                                                     spacing: Metrics.locationStackSpacing)
    private lazy var titleView = UIView(background: .systemBackground)
    private lazy var locationImageView = UIImageView(baseImage: UIImage(named: "location"),
                                                     with: UIColor.customOrange)
    private lazy var locationNameLabel = UILabel(constant: Strings.locationNameLabelText,
                                                 with: Metrics.locationNameLabelSize,
                                                 and: .medium,
                                                 UIColor.customDarkBlue)
    private lazy var locationChangeButton = CustomButton(internalImage: UIImage(systemName: "chevron.down"),
                                                         imageColor: .lightGray,
                                                         backgroundView: .none)
    private lazy var filterButton = CustomButton(internalImage: UIImage(named: "filter"),
                                             imageColor: UIColor.customDarkBlue,
                                             backgroundView: .none)
    private lazy var selectCategoryTitleLabel = UILabel(constant: Strings.selectCategoryTitleConstantText,
                                                        with: Metrics.selectCategoryTitleLabelTextSize,
                                                        and: .bold, UIColor.customDarkBlue)
    private lazy var viewAllButton = UIButton(title: Strings.viewAllButtonTitleConstantText,
                                              and: UIColor.customOrange,
                                              font: UIFont.markProRegular(ofSize: Metrics.viewAllButtonTitleTextSize))
    
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
        addSubview(parentStack)
        parentStack.addArrangedSubviews(locationAndFilterView, titleView)
        locationAndFilterView.addSubviews(locationStackView, filterButton)
        locationStackView.addArrangedSubviews(locationImageView,
                                              locationNameLabel,
                                              locationChangeButton)
        titleView.addSubviews(selectCategoryTitleLabel, viewAllButton)
    }
    
    private func setupLayout() {
        parentStack.fillSuperview()
        
        
        NSLayoutConstraint.activate([
            locationAndFilterView.widthAnchor.constraint(equalTo: parentStack.widthAnchor),
            locationAndFilterView.heightAnchor.constraint(equalTo: parentStack.heightAnchor, multiplier: 1/3)
        ])

        
        NSLayoutConstraint.activate([
            locationStackView.widthAnchor.constraint(equalTo: locationAndFilterView.widthAnchor,
                                                     multiplier: 11/25),
            locationStackView.heightAnchor.constraint(equalToConstant: Metrics.locationStackHeight),
            locationStackView.centerYAnchor.constraint(equalTo: locationAndFilterView.centerYAnchor),
            locationStackView.centerXAnchor.constraint(equalTo: locationAndFilterView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            filterButton.widthAnchor.constraint(equalToConstant: Metrics.filterButtonWidth),
            filterButton.heightAnchor.constraint(equalToConstant: Metrics.filterButtonHeight),
            filterButton.centerYAnchor.constraint(equalTo: locationAndFilterView.centerYAnchor),
            filterButton.rightAnchor.constraint(equalTo: locationAndFilterView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            locationImageView.widthAnchor.constraint(equalToConstant: Metrics.locationImageViewWidth),
            locationImageView.heightAnchor.constraint(equalToConstant: Metrics.locationImageViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            locationChangeButton.widthAnchor.constraint(equalToConstant: Metrics.locationChangeButtonWidth),
            locationChangeButton.heightAnchor.constraint(equalToConstant: Metrics.locationChangeButtonHeight)
        ])
        
        NSLayoutConstraint.activate([
            selectCategoryTitleLabel.widthAnchor.constraint(equalTo: titleView.widthAnchor, multiplier: 11/20),
            selectCategoryTitleLabel.heightAnchor.constraint(equalTo: titleView.heightAnchor),
            selectCategoryTitleLabel.leftAnchor.constraint(equalTo: titleView.leftAnchor),
            selectCategoryTitleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            viewAllButton.widthAnchor.constraint(equalToConstant: Metrics.viewAllButtonWidth),
            viewAllButton.heightAnchor.constraint(equalToConstant: Metrics.viewAllButtonHeight),
            viewAllButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            viewAllButton.rightAnchor.constraint(equalTo: titleView.rightAnchor)
        ])
    }
    
    private func setupView() {
        
    }
}

extension SelectCategoryHeader {
    enum Metrics {
        static let parentStackSpacing: CGFloat = 18
        static let locationStackSpacing: CGFloat = 11
        static let locationStackHeight: CGFloat = 19
        static let locationNameLabelSize: CGFloat = 15
        static let filterButtonWidth: CGFloat = 11
        static let filterButtonHeight: CGFloat = 13
        static let locationImageViewWidth: CGFloat = 12
        static let locationImageViewHeight: CGFloat = 16
        static let locationChangeButtonWidth: CGFloat = 12
        static let locationChangeButtonHeight: CGFloat = 16
        static let selectCategoryTitleLabelTextSize: CGFloat = 25
        static let viewAllButtonTitleTextSize: CGFloat = 15
        static let viewAllButtonWidth: CGFloat = 60
        static let viewAllButtonHeight: CGFloat = 19
    }
    
    enum Strings {
        static let selectCategoryTitleConstantText = "Select Category"
        static let viewAllButtonTitleConstantText = "view all"
        static let locationNameLabelText = "Zihuatanejo, Gro"
    }
}

