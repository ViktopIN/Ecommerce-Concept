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
    private lazy var productNameLabel = UILabel(constant: "Untitled",
                                                with: Metrics.productNameLabelTextSize,
                                                and: .medium,
                                                .customDarkBlue)
    private lazy var favoriteMarkButton = CustomButton(internalObject: UIImage(named: "noFillHeart")!,
                                                       objectColor: .white,
                                                       backgroundView: .roundedCorner(color: .customDarkBlue))
    private lazy var starsStackView: UIStackView = {
        let stackView = UIStackView(with: .horizontal,
                                    distribution: .fillEqually,
                                    spacing: Metrics.starsStackViewSpacing)
        for _ in 1...5 {
            let starImageView = UIImageView(image: UIImage(named: "Star 5"))
            stackView.addArrangedSubview(starImageView)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Container view of the segmented control
    private lazy var segmentedControlContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    // Customised segmented control
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        
        // Remove background and divider colors
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        
        // Append segments
        segmentedControl.insertSegment(withTitle: Strings.shopSegment, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: Strings.detailsSegment, at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: Strings.featuresSegment, at: 2, animated: true)
        
        // Select first segment by default
        segmentedControl.selectedSegmentIndex = 0
        
        // Change text color and the font of the NOT selected (normal) segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.markProRegular(ofSize: 20)], for: .normal)
        
        // Change text color and the font of the selected segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue,
            NSAttributedString.Key.font: UIFont.markProBold(ofSize: 20)], for: .selected)
        
        // Set up event handler to get notified when the selected segment changes
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        // Return false because we will set the constraints with Auto Layout
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
        
    // The underline view below the segmented control
    private lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = .customOrange
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        return underlineView
    }()
    
    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
           return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
       }()
    
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
        detailsContainerView.addSubviews(productNameLabel,
                                         favoriteMarkButton,
                                         starsStackView,
                                         segmentedControlContainerView)
        segmentedControlContainerView.addSubviews(segmentedControl,
                                                  bottomUnderlineView)
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
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: detailsContainerView.topAnchor, constant: Metrics.productNameLabelTopInset),
            productNameLabel.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor, constant: Metrics.productNameLabelLeadingInset),
            productNameLabel.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor,constant: Metrics.productNameLabelTrailingInset),
            productNameLabel.heightAnchor.constraint(equalToConstant: Metrics.productNameLabelHeight)
        ])
        
        NSLayoutConstraint.activate([
            favoriteMarkButton.centerYAnchor.constraint(equalTo: productNameLabel.centerYAnchor),
            favoriteMarkButton.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor, constant: Metrics.favoriteMarkButtonTrailingInset),
            favoriteMarkButton.heightAnchor.constraint(equalToConstant: Metrics.favoriteMarkButtonHeight),
            favoriteMarkButton.widthAnchor.constraint(equalToConstant: Metrics.favoriteMarkButtonWidth)
        ])
        
        NSLayoutConstraint.activate([
            starsStackView.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,
                                                constant: Metrics.starsStackViewTopInset),
            starsStackView.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            starsStackView.widthAnchor.constraint(equalToConstant: Metrics.starsStackViewWidth),
            starsStackView.heightAnchor.constraint(equalToConstant: Metrics.starsStackViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControlContainerView.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 32),
            segmentedControlContainerView.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor),
            segmentedControlContainerView.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: 47)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: segmentedControlContainerView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: segmentedControlContainerView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: 3),
            leadingDistanceConstraint,
            bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments))
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
        
        static let productNameLabelTextSize: CGFloat = 24
        static let productNameLabelTopInset: CGFloat = 28
        static let productNameLabelLeadingInset: CGFloat = 38
        static let productNameLabelTrailingInset: CGFloat = 132
        static let productNameLabelHeight: CGFloat = 30
        
        static let favoriteMarkButtonHeight: CGFloat = 33
        static let favoriteMarkButtonWidth: CGFloat = 37
        static let favoriteMarkButtonTrailingInset: CGFloat = -37
        
        static let starsStackViewSpacing: CGFloat = 9
        static let starsStackViewTopInset: CGFloat = 7
        static let starsStackViewWidth: CGFloat = 126
        static let starsStackViewHeight: CGFloat = 18
    }
    
    enum Strings {
        static let titleLabelText = "Product Details"
        
        static let shopSegment = "Shop"
        static let detailsSegment = "Details"
        static let featuresSegment = "Features"
    }
}

extension ProductDetailsViewController {
    // Configure mainCollectionView Layout
    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        viewModel.generateMainCollectionViewLayout()
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        changeSegmentedControlLinePosition()
    }

    // Change position of the underline
    private func changeSegmentedControlLinePosition() {
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex)
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
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
