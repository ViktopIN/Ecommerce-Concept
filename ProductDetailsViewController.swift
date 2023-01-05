//
//  ProductDetailsViewController.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 04.01.2023.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: Coordinator!
    var viewModel: ProductDetailsViewViewModelType!
    
    // MARK: - Views
    
    private lazy var titleStackView = UIStackView(with: .horizontal,
                                                  distribution: .fill,
                                                  spacing: Metrics.titleStackViewSpacing)
    
    private lazy var backButton = CustomButton(internalObject: UIImage(named: "left-shield")!,
                                               objectColor: .white,
                                               backgroundView: .roundedCorner(color: .customDarkBlue))
    private lazy var titleLabel = UILabel(constant: Strings.titleLabelText,
                                          with: Metrics.titleLabelTextSize,
                                          and: .medium,
                                          .customDarkBlue)
    private lazy var cartButton = CustomButton(internalObject: UIImage(named: "mini-cart")!,
                                               objectColor: .white,
                                               backgroundView: .roundedCorner(color: .customOrange))
    
    private lazy var mainCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: generateCollectionViewLayout())
        collectionView.register(PhonePhotoCell.self,
                                forCellWithReuseIdentifier: PhonePhotoCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var detailsContainerView = UIView(background: .white,
                                                   cornerType: .rounded)
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubviews(titleStackView,
                         mainCollectionView,
                         detailsContainerView)
        titleStackView.addArrangedSubviews(backButton,
                                           titleLabel,
                                           cartButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.titleStackViewTopInset),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.titleStackViewLeadingInset),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Metrics.titleStackViewTrailingInset),
        ])
        NSLayoutConstraint.activate([
            backButton.heightAnchor.constraint(equalToConstant: Metrics.titleButtonHeight),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.titleButtonHeight)
        ])
        NSLayoutConstraint.activate([
            cartButton.heightAnchor.constraint(equalToConstant: Metrics.titleButtonHeight),
            cartButton.widthAnchor.constraint(equalToConstant: Metrics.titleButtonHeight)
        ])
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor,
                                                    constant: Metrics.mainCollectionViewTopInset),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2.79)
        ])
        
        NSLayoutConstraint.activate([
            detailsContainerView.topAnchor.constraint(equalTo: mainCollectionView.bottomAnchor),
            detailsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        

    }
    
    private func setupView() {
        // view setup
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        
        // backButton action
        backButton.addTarget(self,
                             action: #selector(returnToHomeStore), 
                             for: .touchUpInside)
        
        // detailsContainerView setup
        detailsContainerView.layer.masksToBounds = false
        detailsContainerView.layer.shadowColor = UIColor(red: 0.298,
                                                         green: 0.372,
                                                         blue: 0.562,
                                                         alpha: 0.1).cgColor
        detailsContainerView.layer.shadowOpacity = 1
        detailsContainerView.layer.shadowRadius = 20
        detailsContainerView.layer.shadowOffset = CGSize(width: 0, height: -5)
    }
    
    @objc
    func returnToHomeStore() {
        coordinator.showHomeStoreView()
    }

}

// MARK: - Metrics extension

extension ProductDetailsViewController {
    enum Metrics {
        static let titleStackViewSpacing: CGFloat = 51
        static let titleStackViewTopInset: CGFloat = 79
        static let titleStackViewLeadingInset: CGFloat = 42
        static let titleStackViewTrailingInset: CGFloat = -35
        
        static let titleButtonHeight: CGFloat = 37
        
        static let titleLabelTextSize: CGFloat = 18
        static let titleLabelWidth: CGFloat = 173
        
        static let mainCollectionViewTopInset: CGFloat = 30
        static let mainCollectionViewHeight: CGFloat = 349
    }
    
    enum Strings {
        static let titleLabelText = "Product Details"
    }
}

extension ProductDetailsViewController {
    // Configure mainCollectionView Layout
    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        viewModel.generateMainCollectionViewLayout()
    }
}

extension ProductDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhonePhotoCell.reuseIdentifier,
                                                            for: indexPath) as? PhonePhotoCell else { fatalError() }
        return cell
    }
}
