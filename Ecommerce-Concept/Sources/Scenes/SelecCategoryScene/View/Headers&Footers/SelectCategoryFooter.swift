//
//  SelectCategoryFooter.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit

class SelectCategoryFooter: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let sectionFooter = "selectCategory-section-footer-element-kind"
    static let reuseID = "SelectCategoryFooter"
    
    //  MARK: - Views
    
    private lazy var parentStack = UIStackView(with: .horizontal,
                                               spacing: Metrics.parentStackSpacing)
    private lazy var magnifyingglassStackView: UIStackView = {
        let stackView = UIStackView(with: .horizontal,
                                    distribution: .fillEqually)
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(.customOrange,
                                                                          renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        let leftView = UIView(background: .clear)
        let rightView = UIView(background: .clear)
        stackView.addArrangedSubviews(leftView, imageView, rightView)
        return stackView
    }()
    
    private lazy var inCategorySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Strings.inCategorySearchBarPlaceholder
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.cornerRadius = Metrics.inCategroySearchBarCornerRadius
        searchBar.searchTextField.leftView = self.magnifyingglassStackView
        searchBar.searchTextField.font = UIFont.markProRegular(ofSize: Metrics.inCategroySearchBarTextSize)
        searchBar.layer.cornerRadius = Metrics.inCategroySearchBarCornerRadius
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private lazy var qrCodeButton = CustomButton(internalImage: UIImage(named: "qrCode"),
                                                 imageColor: .white,
                                                 backgroundView: .circle(color: UIColor.orange,
                                                                                                                                      buttonHeight: Metrics.qrButtonHeight))
    
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
        addSubviews(parentStack)
        parentStack.addArrangedSubviews(inCategorySearchBar, qrCodeButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            parentStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            parentStack.leftAnchor.constraint(equalTo: leftAnchor, constant: Metrics.parentStackLeftInset),
            parentStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 93/100),
            parentStack.heightAnchor.constraint(equalToConstant: Metrics.qrButtonHeight)
        ])
        
        NSLayoutConstraint.activate([
            qrCodeButton.widthAnchor.constraint(equalToConstant: Metrics.qrButtonHeight)
        ])
    }
}

extension SelectCategoryFooter {
    enum Metrics {
        static let parentStackSpacing: CGFloat = 11
        static let parentStackLeftInset: CGFloat = 15
        static let magnifyingglassImageViewMargins = UIEdgeInsets(top: 0,
                                                                  left: 20,
                                                                  bottom: 0,
                                                                  right: 20)
        static let inCategroySearchBarCornerRadius: CGFloat = 20
        static let inCategroySearchBarTextSize: CGFloat = 12
        static let qrButtonHeight: CGFloat = 34
    }
    
    enum Strings {
        static let inCategorySearchBarPlaceholder = "Search"
    }
}
