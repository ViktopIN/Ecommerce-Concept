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
        segmentedControl.selectedSegmentTintColor = .clear
        segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(),
                                         forLeftSegmentState: .normal,
                                         rightSegmentState: .normal,
                                         barMetrics: .default)
        

        
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
    
    private lazy var centerXConstraintUnderLine: NSLayoutConstraint = {
        return bottomUnderlineView.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor,
                                                            constant: -((UIScreen.main.bounds.width - 67) / CGFloat(segmentedControl.numberOfSegments)))
       }()
    private lazy var underlineWidthConstraint: NSLayoutConstraint = {
        return bottomUnderlineView.widthAnchor.constraint(equalToConstant: (segmentedControl.titleForSegment(at: 0)?.width(withConstrainedHeight: 11,
                                                                                                                           font: .markProBold(ofSize: 20)))!)
    }()
    private lazy var productSpecificationStack = ProductSpecificationStackView(cpuLabel: cpuLabel,
                                                                               cameraLabel: cameraLabel,
                                                                               ramLabel: ramLabel,
                                                                               hddLabel: hddLabel)
    
    private lazy var cpuLabel = UILabel(constant: "Unknown",
                                        with: Metrics.specificationLabelsTextSize,
                                        and: .regular,
                                        .lightGray)
    private lazy var cameraLabel = cpuLabel.copy() as! UILabel
    private lazy var ramLabel = cpuLabel.copy() as! UILabel
    private lazy var hddLabel = cpuLabel.copy() as! UILabel
    private lazy var selectColorAndCapacityTitleLabel = UILabel(constant: Strings.selectColorAndCapacityTitleLabelText,
                                                                with: Metrics.selectColorAndCapacityTitleLabelTextSize,
                                                                and: .medium,
                                                                .customDarkBlue)
    private lazy var firstColorTypeButton = CustomButton(internalObject: nil,
                                                         objectColor: nil,
                                                         backgroundView: .circle(color: .gray,
                                                                                 buttonHeight: Metrics.colorTypeButtonHeight))
    
    private lazy var secondColorTypeButton = CustomButton(internalObject: nil,
                                                          objectColor: nil,
                                                          backgroundView: .circle(color: .gray,
                                                                                  buttonHeight: Metrics.colorTypeButtonHeight))
    
    private lazy var firstAmountOfMemoryButton = CustomButton(internalObject: "? Gb",
                                                              objectColor: .white,
                                                              backgroundView: .roundedCorner(color: .customOrange),
                                                              textStyle: .smallButtonStyle)
    private lazy var secondAmountOfMemoryButton = CustomButton(internalObject: "? Gb",
                                                               objectColor: .lightGray,
                                                               backgroundView: .roundedCorner(color: .white),
                                                               textStyle: .smallButtonStyle)
    private lazy var addToCartButton = CustomButton(internalObject: "Add to Cart        ?",
                                                    objectColor: .white,
                                                    backgroundView: .roundedCorner(color: .customOrange),
                                                    textStyle: .bigButtonStyle)
    
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
                                         segmentedControlContainerView,
                                         productSpecificationStack,
                                         selectColorAndCapacityTitleLabel,
                                         firstColorTypeButton,
                                         secondColorTypeButton,
                                         firstAmountOfMemoryButton,
                                         secondAmountOfMemoryButton,
                                         addToCartButton)
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
            segmentedControlContainerView.topAnchor.constraint(equalTo: starsStackView.bottomAnchor,
                                                               constant: Metrics.segmentedControlContainerViewTopInset),
            segmentedControlContainerView.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor,
                                                                   constant: Metrics.segmentedControlContainerViewLeadingInset),
            segmentedControlContainerView.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor,
                                                                    constant: Metrics.segmentedControlContainerViewTrailingInset),
            segmentedControlContainerView.heightAnchor.constraint(equalToConstant: Metrics.segmentedControlContainerViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: segmentedControlContainerView.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: segmentedControlContainerView.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalTo: segmentedControlContainerView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: 3),
            centerXConstraintUnderLine,
            underlineWidthConstraint
            ])
        
        NSLayoutConstraint.activate([
            productSpecificationStack.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            productSpecificationStack.topAnchor.constraint(equalTo: segmentedControlContainerView.bottomAnchor,
                                                           constant: Metrics.productSpecificationStackTopInset),
            productSpecificationStack.trailingAnchor.constraint(equalTo: segmentedControlContainerView.trailingAnchor),
            productSpecificationStack.heightAnchor.constraint(equalToConstant: Metrics.productSpecificationStackHeight)
        ])
        
        NSLayoutConstraint.activate([
            selectColorAndCapacityTitleLabel.topAnchor.constraint(equalTo: productSpecificationStack.bottomAnchor, constant: Metrics.selectColorAndCapacityTitleLabelTopInset),
            selectColorAndCapacityTitleLabel.leadingAnchor.constraint(equalTo: productSpecificationStack.leadingAnchor),
            selectColorAndCapacityTitleLabel.heightAnchor.constraint(equalToConstant: (selectColorAndCapacityTitleLabel.text?.height(withConstrainedWidth: 0,
                                                                                                                                     font: .markProMedium(ofSize: Metrics.selectColorAndCapacityTitleLabelTextSize)))!),
            selectColorAndCapacityTitleLabel.widthAnchor.constraint(equalToConstant: (selectColorAndCapacityTitleLabel.text?.width(withConstrainedHeight: 8,
                                                                                                                                   font: .markProMedium(ofSize: Metrics.selectColorAndCapacityTitleLabelTextSize)))!),

        ])
        
        NSLayoutConstraint.activate([
            firstColorTypeButton.topAnchor.constraint(equalTo: selectColorAndCapacityTitleLabel.bottomAnchor, constant: Metrics.firstColorTypeButtonTopInset),
            firstColorTypeButton.leadingAnchor.constraint(equalTo: selectColorAndCapacityTitleLabel.leadingAnchor),
            firstColorTypeButton.heightAnchor.constraint(equalToConstant: Metrics.colorTypeButtonHeight),
            firstColorTypeButton.widthAnchor.constraint(equalToConstant: Metrics.colorTypeButtonHeight),
            secondColorTypeButton.topAnchor.constraint(equalTo: firstColorTypeButton.topAnchor),
            secondColorTypeButton.leadingAnchor.constraint(equalTo: firstColorTypeButton.trailingAnchor, constant: Metrics.secondColorTypeButtonLeadingInset),
            secondColorTypeButton.heightAnchor.constraint(equalToConstant: Metrics.colorTypeButtonHeight),
            secondColorTypeButton.widthAnchor.constraint(equalToConstant: Metrics.colorTypeButtonHeight)
        ])
        
        NSLayoutConstraint.activate([
            firstAmountOfMemoryButton.centerYAnchor.constraint(equalTo: secondColorTypeButton.centerYAnchor),
            firstAmountOfMemoryButton.leadingAnchor.constraint(equalTo: secondColorTypeButton.trailingAnchor,
                                                               constant: Metrics.firstAmountOfMemoryButtonLeadingInset),
            firstAmountOfMemoryButton.widthAnchor.constraint(equalToConstant: Metrics.amountOfMemoryButtonsWidht),
            firstAmountOfMemoryButton.heightAnchor.constraint(equalToConstant: Metrics.amountOfMemoryButtonsHeight),
            secondAmountOfMemoryButton.centerYAnchor.constraint(equalTo: firstAmountOfMemoryButton.centerYAnchor),
            secondAmountOfMemoryButton.leadingAnchor.constraint(equalTo: firstAmountOfMemoryButton.trailingAnchor, constant: Metrics.secondAmountOfMemoryButtonLeadingInset),
            secondAmountOfMemoryButton.heightAnchor.constraint(equalToConstant: Metrics.amountOfMemoryButtonsHeight),
            secondAmountOfMemoryButton.widthAnchor.constraint(equalToConstant: Metrics.amountOfMemoryButtonsWidht)
        ])
        
        NSLayoutConstraint.activate([
            addToCartButton.topAnchor.constraint(equalTo: firstColorTypeButton.bottomAnchor,
                                                 constant: Metrics.firstAmountOfMemoryButtonTopInset),
            addToCartButton.leadingAnchor.constraint(equalTo: segmentedControlContainerView.leadingAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: segmentedControlContainerView.trailingAnchor),
            addToCartButton.heightAnchor.constraint(equalToConstant: Metrics.addToCartButtonHeight)
        ])
    }
    
    private func setupView() {
        // view and viewModel setup
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
                self.productNameLabel.text = self.viewModel.provideProductTitle()
                self.viewModel.fillSpecifications(cpuSpecication: self.cpuLabel,
                                                  cameraSpecification: self.cameraLabel,
                                                  ramSpecification: self.ramLabel,
                                                  hddSpecification: self.hddLabel,
                                                  within: self.productSpecificationStack)
                self.viewModel.provideColorsToColorTypeButtons(first: self.firstColorTypeButton,
                                                               second: self.secondColorTypeButton)
            }
        }
        
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
        
        // colorButton setup
        firstColorTypeButton.addCheckMarkToButton()
        firstColorTypeButton.addTarget(self,
                                       action: #selector(colorTypeButtonTap),
                                       for: .touchUpInside)
        firstColorTypeButton.isSelected = true
        secondColorTypeButton.addCheckMarkToButton()
        secondColorTypeButton.addTarget(self,
                                        action: #selector(colorTypeButtonTap),
                                        for: .touchUpInside)
        // amountButton setup
        firstAmountOfMemoryButton.addTarget(self,
                                            action: #selector(amountOfMemoryButton),
                                            for: .touchUpInside)
        secondAmountOfMemoryButton.addTarget(self,
                                             action: #selector(amountOfMemoryButton),
                                             for: .touchUpInside)
    }
    
    // MARK: - Methods
    
    @objc
    private func returnToHomeStore() {
        coordinator.showHomeStoreView()
    }
    
    @objc
    private func colorTypeButtonTap(_ sender: CustomButton) {
        guard sender.isSelected != true else { return }
        sender.isSelected.toggle()
        if sender == firstColorTypeButton {
            secondColorTypeButton.isSelected = !firstColorTypeButton.isSelected
        } else {
            firstColorTypeButton.isSelected = !secondColorTypeButton.isSelected
        }
    }
    
    @objc
    private func amountOfMemoryButton(_ sender: CustomButton) {
        guard sender.backgroundColor != .customOrange else { return }
        if sender == firstAmountOfMemoryButton {
            firstAmountOfMemoryButton.backgroundColor = .customOrange
            firstAmountOfMemoryButton.setTitleColor(.white, for: .normal)
            secondAmountOfMemoryButton.backgroundColor = .white
            secondAmountOfMemoryButton.setTitleColor(.lightGray, for: .normal)
        } else {
            secondAmountOfMemoryButton.backgroundColor = .customOrange
            secondAmountOfMemoryButton.setTitleColor(.white, for: .normal)
            firstAmountOfMemoryButton.backgroundColor = .white
            firstAmountOfMemoryButton.setTitleColor(.lightGray, for: .normal)
        }
    }
}

// MARK: - Metrics extension

extension ProductDetailsViewController {
    enum Metrics {
        static let titleStackViewSpacing: CGFloat = 51
        static let titleStackViewTopInset: CGFloat = 68
        static let titleStackViewLeadingInset: CGFloat = 42
        static let titleStackViewTrailingInset: CGFloat = -35
        
        static let titleButtonHeight: CGFloat = 37
        
        static let titleLabelTextSize: CGFloat = 18
        static let titleLabelWidth: CGFloat = 173
        
        static let mainCollectionViewTopInset: CGFloat = 22
        static let mainCollectionViewHeight: CGFloat = 349
        
        static let productNameLabelTextSize: CGFloat = 24
        static let productNameLabelTopInset: CGFloat = 20
        static let productNameLabelLeadingInset: CGFloat = 38
        static let productNameLabelTrailingInset: CGFloat = 132
        static let productNameLabelHeight: CGFloat = 30
        
        static let favoriteMarkButtonHeight: CGFloat = 33
        static let favoriteMarkButtonWidth: CGFloat = 37
        static let favoriteMarkButtonTrailingInset: CGFloat = -37
        
        static let starsStackViewSpacing: CGFloat = 9
        static let starsStackViewTopInset: CGFloat = 5
        static let starsStackViewWidth: CGFloat = 126
        static let starsStackViewHeight: CGFloat = 18
        
        static let segmentedControlContainerViewTopInset: CGFloat = 25
        static let segmentedControlContainerViewLeadingInset: CGFloat = 25
        static let segmentedControlContainerViewTrailingInset: CGFloat = -40
        static let segmentedControlContainerViewHeight: CGFloat = 36
    
        static let specificationLabelsTextSize: CGFloat = 11
        
        static let productSpecificationStackHeight: CGFloat = 50
        static let productSpecificationStackTopInset: CGFloat = 28
        
        static let selectColorAndCapacityTitleLabelTextSize: CGFloat = 16
        static let selectColorAndCapacityTitleLabelTopInset: CGFloat = 27
        
        static let colorTypeButtonHeight: CGFloat = 39
        static let firstColorTypeButtonTopInset: CGFloat = 10
        static let secondColorTypeButtonLeadingInset: CGFloat = 18
        
        static let firstAmountOfMemoryButtonLeadingInset: CGFloat = 73
        static let amountOfMemoryButtonsWidht: CGFloat = 71
        static let amountOfMemoryButtonsHeight: CGFloat = 30
        
        static let secondAmountOfMemoryButtonLeadingInset: CGFloat = 20
        
        static let firstAmountOfMemoryButtonTopInset: CGFloat = 25
        static let addToCartButtonHeight: CGFloat = 54
    }
    
    enum Strings {
        static let titleLabelText = "Product Details"
        
        static let shopSegment = "Shop"
        static let detailsSegment = "Details"
        static let featuresSegment = "Features"
        
        static let selectColorAndCapacityTitleLabelText = "Select color and capacity"
    }
}

extension ProductDetailsViewController {
    // Configure mainCollectionView Layout
    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        viewModel.generateMainCollectionViewLayout()
    }
    
    @objc
    private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        changeSegmentedControlLinePosition()
    }

    // Change position of the underline
    private func changeSegmentedControlLinePosition() {
        // index relative to the middle segment
        let segmentIndex = CGFloat(segmentedControl.selectedSegmentIndex) - 1
        let segmentWidth = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.centerXConstraintUnderLine.constant = leadingDistance
            self?.underlineWidthConstraint.constant = (self?.segmentedControl.titleForSegment(at: Int(segmentIndex + 1))?.width(withConstrainedHeight: 11,
                                                                                                                 font: .markProBold(ofSize: 20)))!
            self?.view.layoutIfNeeded()
        })
    }
}

extension ProductDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhonePhotoCell.reuseIdentifier,
                                                            for: indexPath) as? PhonePhotoCell else { fatalError() }
        
        cell.loadingImageURLAdress = viewModel.provideLoadingImageURL(indexPath: indexPath)
        return cell
    }
}
