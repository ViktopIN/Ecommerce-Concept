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
    weak var modelView: BestSellerCellViewModelType? {
        willSet(modelView) {
            guard let modelView = modelView else { return }
            mainImageView.image = modelView.picture
            currentPriceLabel.text = modelView.discountPrice
            oldPriceLabel.attributedText = modelView.priceWithoutDiscount
            nameLabel.text = modelView.title
        }
    }
    
    //  MARK: - Views
    
    private lazy var fillingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Metrics.fillingViewCornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var parentStack = UIStackView(with: .vertical)
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var descriptionStack = UIStackView(with: .vertical,
                                                    spacing: Metrics.descriptionStackSpacing,
                                                    layoutMargins: Metrics.descriptionStackLayoutMargins)
    private var priceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        descriptionStack.addArrangedSubviews(priceView, nameLabel)
        priceView.addSubviews(currentPriceLabel, oldPriceLabel)
    }
    
    private func setupLayout() {
        fillingView.fillSuperview()
        parentStack.fillSuperview()
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalTo: parentStack.widthAnchor),
            mainImageView.heightAnchor.constraint(equalTo: parentStack.heightAnchor, multiplier: 3/4)
        ])
        
        NSLayoutConstraint.activate([
            priceView.heightAnchor.constraint(equalTo: descriptionStack.heightAnchor, multiplier: 1/2)
        ])
        
        NSLayoutConstraint.activate([
            currentPriceLabel.heightAnchor.constraint(equalToConstant: Metrics.currentPriceLabelHeight),
            currentPriceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor),
            currentPriceLabel.leftAnchor.constraint(equalTo: priceView.leftAnchor),
            currentPriceLabel.rightAnchor.constraint(equalTo: oldPriceLabel.leftAnchor, constant: Metrics.oldPriceLabelLeftInset)
        ])
        
        NSLayoutConstraint.activate([
            oldPriceLabel.heightAnchor.constraint(equalToConstant: Metrics.oldPriceLabelHeight),
            oldPriceLabel.bottomAnchor.constraint(equalTo: priceView.bottomAnchor),
            oldPriceLabel.rightAnchor.constraint(lessThanOrEqualTo: priceView.rightAnchor)
        ])
    }
    
    private func setupView() {
        descriptionStack.alignment = .leading
    }
}

// MARK: - Extension

extension BestSellerCell {
    enum Metrics {
        static let fillingViewCornerRadius: CGFloat = 10
        static let descriptionStackSpacing: CGFloat = 5
        static let descriptionStackLayoutMargins = UIEdgeInsets(top: 0,
                                                          left: 20,
                                                          bottom: 15,
                                                          right: 0)
        static let currentPriceLabelTextSize: CGFloat = 16
        static let currentPriceLabelHeight: CGFloat = 20
        static let nameLabelTextSize: CGFloat = 10
        static let oldPriceLabelHeight: CGFloat = 13
        static let oldPriceLabelLeftInset: CGFloat = -7
    }
}
