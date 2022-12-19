//
//  HotSalesCell.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 14.12.2022.
//


import UIKit

class HotSalesCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "HotSalesCell"
    
    //  MARK: - Views
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Metrics.mainImageViewCornerRadius
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var hotSalesContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newLogo = UILabel(constant: Strings.newLogoConstantText,
                                       with: Metrics.newLogoTextSize,
                                       and: .bold,
                                       .white)
    private lazy var hotSalesNameLabel = UILabel(with: Metrics.hotSalesNameLabelTextSize,
                                                 and: .bold,
                                                 .white)
    private lazy var hotSalesDescriptionLabel = UILabel(with: Metrics.hotSalesDescriptionLabelTextSize,
                                                        and: .regular,
                                                        .white)
    private lazy var buyNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = Metrics.buyNowButtonCornerRadius
        button.layer.masksToBounds = true
        button.setTitle(Strings.buyNowButtonConstantText,
                        for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .markProBold(ofSize: Metrics.buyNowButtonTextSize)

        return button
    }()
    
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
        addSubview(mainImageView)
        mainImageView.addSubview(hotSalesContentView)
        hotSalesContentView.addSubviews(newLogo,
                                        hotSalesNameLabel,
                                        hotSalesDescriptionLabel,
                                        buyNowButton)
    }
    
    private func setupLayout() {
        mainImageView.fillSuperview()
        NSLayoutConstraint.activate([
            hotSalesContentView.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: Metrics.hotSalesContentViewTopInset),
            hotSalesContentView.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: Metrics.hotSalesContentViewBottomInset),
            hotSalesContentView.leftAnchor.constraint(equalTo: mainImageView.leftAnchor, constant: Metrics.hotSalesContentViewLeftInset),
            hotSalesContentView.widthAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 2/5)
        ])
        
        NSLayoutConstraint.activate([
            newLogo.topAnchor.constraint(equalTo: hotSalesContentView.topAnchor),
            newLogo.leftAnchor.constraint(equalTo: hotSalesContentView.leftAnchor),
            newLogo.heightAnchor.constraint(equalToConstant: Metrics.newLogoHeight),
            newLogo.widthAnchor.constraint(equalToConstant: Metrics.newLogoHeight)
        ])
        
        NSLayoutConstraint.activate([
            hotSalesNameLabel.topAnchor.constraint(equalTo: newLogo.bottomAnchor, constant: Metrics.hotSalesNameLabelTopInset),
            hotSalesNameLabel.leftAnchor.constraint(equalTo: hotSalesContentView.leftAnchor),
            hotSalesNameLabel.widthAnchor.constraint(equalTo: hotSalesContentView.widthAnchor),
            hotSalesNameLabel.heightAnchor.constraint(equalToConstant: Metrics.hotSalesNameLabelHeight)
        ])
        
        NSLayoutConstraint.activate([
            hotSalesDescriptionLabel.topAnchor.constraint(equalTo: hotSalesNameLabel.bottomAnchor, constant: Metrics.hotSalesDescriptionLabelTopInset),
            hotSalesDescriptionLabel.leftAnchor.constraint(equalTo: hotSalesContentView.leftAnchor),
            hotSalesDescriptionLabel.widthAnchor.constraint(equalTo: hotSalesContentView.widthAnchor),
            hotSalesDescriptionLabel.heightAnchor.constraint(equalToConstant: Metrics.hotSalesDescriptionLabelHeight)
        ])
        
        NSLayoutConstraint.activate([
            buyNowButton.topAnchor.constraint(equalTo: hotSalesDescriptionLabel.bottomAnchor, constant: Metrics.buyNowButtonTopInset),
            buyNowButton.bottomAnchor.constraint(equalTo: hotSalesContentView.bottomAnchor),
            buyNowButton.leftAnchor.constraint(equalTo: hotSalesContentView.leftAnchor),
            buyNowButton.widthAnchor.constraint(equalToConstant: Metrics.buyNowButtonWidht)
        ])

    }
    
    private func setupView() {
        // New logo  setup
        newLogo.backgroundColor = .customOrange
        newLogo.layer.cornerRadius = Metrics.newLogoHeight / 2
        newLogo.layer.masksToBounds = true
        newLogo.textAlignment = .center
    }
    
    // MARK: - Configure Method
    
    func configureCell(model: ItemModel) {
        mainImageView.image = model.image
        hotSalesNameLabel.text = model.name
        hotSalesDescriptionLabel.text = model.description ?? "" 
        newLogo.isHidden = !(model.isNew ?? false)
    }
}

extension HotSalesCell {
    enum Metrics {
        static let mainImageViewCornerRadius: CGFloat = 20
        static let newLogoTextSize: CGFloat = 10
        static let newLogoHeight: CGFloat = 27
        static let hotSalesContentViewTopInset: CGFloat = 16
        static let hotSalesContentViewBottomInset: CGFloat = -10
        static let hotSalesContentViewLeftInset: CGFloat = 24
        static let hotSalesNameLabelTextSize: CGFloat = 25
        static let hotSalesNameLabelTopInset: CGFloat = 18
        static let hotSalesNameLabelHeight: CGFloat = 30
        static let hotSalesDescriptionLabelTextSize: CGFloat = 11
        static let hotSalesDescriptionLabelTopInset: CGFloat = 5
        static let hotSalesDescriptionLabelHeight: CGFloat = 13
        static let buyNowButtonTopInset: CGFloat = 26
        static let buyNowButtonWidht: CGFloat = 98
        static let buyNowButtonTextSize: CGFloat = 11
        static let buyNowButtonCornerRadius: CGFloat = 5
    }
    
    enum Strings {
        static let newLogoConstantText = "New"
        static let buyNowButtonConstantText = "Buy now!"
    }
}
