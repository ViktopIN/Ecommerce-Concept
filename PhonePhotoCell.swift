//
//  PhonePhotoCell.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 04.01.2023.
//

import UIKit

final class PhonePhotoCell: UICollectionViewCell {
    
    // MARK: - Propertiex
    
    static let reuseIdentifier = "PhonePhotoCell"
    weak var viewModel: PhonePhotoCellViewModelType!
    
    // MARK: - Views
    
    private lazy var placeHolderActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Initialiser
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        addSubviews(mainImageView, placeHolderActivityIndicator)
    }
    
    private func setupLayout() {
        mainImageView.fillSuperview()
        NSLayoutConstraint.activate([
            placeHolderActivityIndicator.centerXAnchor.constraint(equalTo: mainImageView.centerXAnchor),
            placeHolderActivityIndicator.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor)
        ])
    }
    
    private func setupViews() {
        // ContainerView setup
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
        
        
    }
}
