//
//  BestSellerCell.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//

import UIKit

class BestSellerCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "BestSellerCell"
    
    //  MARK: - Views
    
    private lazy var fillingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Metrics.fillingViewCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var parentStack = UIStackView(with: .vertical,
                                               spacing: Metrics.parentStackSpacing)
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var descriptionStack = UIStackView(with: .vertical,
                                                    spacing: Metrics.descriptionStackSpacing,
                                                    layoutMargins: Metrics.descriptionStackLayoutMargins)
    
    private lazy var priceStack = UIStackView(with: .horizontal,
                                              spacing: Metrics.priceStackSpacing)
    private lazy var currentPriceLabel = UILabel(with: Metrics.currentPriceLabelTextSize,
                                                 and: .bold)
    private lazy var oldPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var nameLabel = UILabel(with: Metrics.nameLabelTextSize,
                                         and: .regular)
    
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
        addSubview(fillingView)
        fillingView.addSubview(parentStack)
        parentStack.addArrangedSubviews(mainImageView, descriptionStack)
        descriptionStack.addArrangedSubviews(priceStack, nameLabel)
        priceStack.addArrangedSubviews(currentPriceLabel, oldPriceLabel)
    }
    
    private func setupLayout() {
        fillingView.fillSuperview()
        parentStack.fillSuperview()
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalTo: parentStack.widthAnchor),
            mainImageView.heightAnchor.constraint(equalTo: parentStack.heightAnchor, multiplier: 3/4)
        ])
        
        NSLayoutConstraint.activate([
            priceStack.widthAnchor.constraint(equalTo: descriptionStack.widthAnchor),
            priceStack.heightAnchor.constraint(equalTo: descriptionStack.heightAnchor, multiplier: 1/2)
        ])
        
        NSLayoutConstraint.activate([
            currentPriceLabel.widthAnchor.constraint(equalToConstant: Metrics.currentPriceLabelWidth),
            currentPriceLabel.heightAnchor.constraint(equalToConstant: Metrics.currentPriceLabelHeight),
            currentPriceLabel.bottomAnchor.constraint(equalTo: priceStack.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            oldPriceLabel.widthAnchor.constraint(equalToConstant: Metrics.oldPriceLabelWidth),
            oldPriceLabel.heightAnchor.constraint(equalToConstant: Metrics.oldPriceLabelHeight),
            oldPriceLabel.bottomAnchor.constraint(equalTo: priceStack.bottomAnchor)
        ])

    }
    
    private func setupView() {
        descriptionStack.alignment = .leading
    }
    
    // MARK: - Configure method
    
    func configureCell(model: ItemModel) {
        let model = model as BestSellerItemModelType
        mainImageView.image = model.image
        currentPriceLabel.text = model.currentPrice
        oldPriceLabel.text = model.oldPrice
        nameLabel.text = model.name
    }
}

// MARK: - Extension

extension BestSellerCell {
    enum Metrics {
        static let fillingViewCornerRadius: CGFloat = 10
        static let parentStackSpacing: CGFloat = 7
        static let descriptionStackSpacing: CGFloat = 5
        static let descriptionStackLayoutMargins = UIEdgeInsets(top: 5,
                                                          left: 20,
                                                          bottom: 15,
                                                          right: 0)
        static let priceStackSpacing: CGFloat = 7
        static let currentPriceLabelTextSize: CGFloat = 16
        static let currentPriceLabelWidth: CGFloat = 42
        static let currentPriceLabelHeight: CGFloat = 20
        static let nameLabelTextSize: CGFloat = 10
        static let oldPriceLabelWidth: CGFloat = 27
        static let oldPriceLabelHeight: CGFloat = 27
    }
}
