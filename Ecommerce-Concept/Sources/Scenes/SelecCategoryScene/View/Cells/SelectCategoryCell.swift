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
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.layer.contentsScale = 6
        imageView.layer.cornerRadius = Metrics.mainImageViewHeight / 2
        imageView.layer.shadowColor = Metrics.mainImageViewShadowColor
        imageView.layer.shadowOpacity = Metrics.mainImageViewShadowOpacity
        imageView.layer.shadowRadius = Metrics.mainImageViewShadowRadius
        imageView.layer.shadowOffset = Metrics.mainImageViewShadowOffset
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mainLabel = UILabel(with: Metrics.mainLabelTextSize,
                                         and: .medium,
                                         UIColor.customDarkBlue)
    
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
        addSubviews(mainImageView, mainLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: topAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: Metrics.mainImageViewHeight),
            mainImageView.widthAnchor.constraint(equalToConstant: Metrics.mainImageViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainLabel.leftAnchor.constraint(equalTo: leftAnchor),
            mainLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func setupView() {
        backgroundColor = .clear
        mainLabel.textAlignment = .center
    }
    
    // MARK: - Methods
    
    func configureCell(configure image: UIImage,
                       isSelected state: Bool,
                       and text: String) {
        mainLabel.text = text
        if state {
            mainImageView.image = image.withTintColor(.white,
                                                      renderingMode: .alwaysOriginal)
            mainLabel.textColor = UIColor.customOrange
            mainImageView.backgroundColor = UIColor.customOrange
        } else {
            mainImageView.image = image.withTintColor(.lightGray,
                                                      renderingMode: .alwaysOriginal)
            mainLabel.textColor = UIColor.customDarkBlue
            mainImageView.backgroundColor = .white
        }
    }
}

extension SelectCategoryCell {
    enum Metrics {
        static let mainImageViewHeight: CGFloat = 71
        static let mainLabelTextSize: CGFloat = 12
        static let mainImageViewShadowColor: CGColor = UIColor(red: 0.656,
                                                               green: 0.669,
                                                               blue: 0.788,
                                                               alpha: 0.15).cgColor
        static let mainImageViewShadowOpacity: Float = 1
        static let mainImageViewShadowRadius: CGFloat = 20
        static let mainImageViewShadowOffset = CGSize(width: 0,
                                                      height: 0)
        
    }
}
