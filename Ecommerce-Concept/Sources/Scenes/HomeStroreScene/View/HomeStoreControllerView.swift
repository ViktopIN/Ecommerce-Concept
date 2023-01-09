//
//  HomeStoreControllerView.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 08.12.2022.
//

import UIKit

class HomeStoreControllerView: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: HomeStoreViewModelType!
    var coordinator: CoordinatorProtocol?
    
    
    // MARK: - Views
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<HomeStoreSectionsModel, AnyHashable>! = nil
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: generateCollectionViewLayout())
        collectionView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        collectionView.register(SelectCategoryCell.self,
                                forCellWithReuseIdentifier: SelectCategoryCell.reuseID)
        collectionView.register(SelectCategoryHeader.self,
                                forSupplementaryViewOfKind: SelectCategoryHeader.sectionHeader,
                                withReuseIdentifier: SelectCategoryHeader.reuseID)
        collectionView.register(SelectCategoryFooter.self,
                                forSupplementaryViewOfKind: SelectCategoryFooter.sectionFooter,
                                withReuseIdentifier: SelectCategoryFooter.reuseID)
        collectionView.register(HotSalesCell.self,
                                forCellWithReuseIdentifier: HotSalesCell.reuseID)
        collectionView.register(HotSalesHeader.self,
                                forSupplementaryViewOfKind: HotSalesHeader.sectionHeader,
                                withReuseIdentifier: HotSalesHeader.reuseID)
        collectionView.register(BestSellerCell.self,
                                forCellWithReuseIdentifier: BestSellerCell.reuseID)
        collectionView.register(BestSellerHeader.self,
                                forSupplementaryViewOfKind: BestSellerHeader.sectionHeader,
                                withReuseIdentifier: BestSellerHeader.reuseID)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    private lazy var homeStoreTabBar = UIView(background: .customDarkBlue,
                                              cornerType: .rounded)
    private lazy var tabBarStack = UIStackView(with: .horizontal)
    private lazy var buttonStack = UIStackView(with: .horizontal,
                                               distribution: .fillEqually)
    private lazy var explorerLabel: UILabel = {
        let label = UILabel()
        label.attributedText = viewModel.makeAttributedText(with: UIImage(named: "round") ?? UIImage(),
                                                            text: Strings.explorerLabelText,
                                                            textAttributes: [.foregroundColor : UIColor.white,
                                                                             .font: UIFont.markProBold(ofSize: Metrics.explorerLabelTextSize)],
                                                            textIsFirst: false)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var showCartButton = makeButton(image: UIImage(named: "cart") ?? UIImage(),
                                             action: action)
    private lazy var favoritesButton = makeButton(image: UIImage(named: "heart") ?? UIImage(),
                                                  action: action)
    private lazy var profileButton = makeButton(image: UIImage(named: "profile") ?? UIImage(),
                                                action: action)
    
    let action = UIAction {_ in
        print("action")
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        
        view.addSubviews(collectionView)
        view.addSubview(homeStoreTabBar)
        homeStoreTabBar.addSubview(tabBarStack)
        tabBarStack.addArrangedSubviews(explorerLabel,
                                        buttonStack)
        buttonStack.addArrangedSubviews(showCartButton,
                                        favoritesButton,
                                        profileButton)
    }
    
    private func setupLayout() {
        
        collectionView.fillSuperview()
        NSLayoutConstraint.activate([
            homeStoreTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeStoreTabBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            homeStoreTabBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.085)
        ])
        NSLayoutConstraint.activate([
            tabBarStack.centerYAnchor.constraint(equalTo: homeStoreTabBar.centerYAnchor),
            tabBarStack.heightAnchor.constraint(equalTo: homeStoreTabBar.heightAnchor,
                                                multiplier: 1/4),
            tabBarStack.leftAnchor.constraint(equalTo: homeStoreTabBar.leftAnchor,
                                              constant: Metrics.tabBarStackLeftInset),
            tabBarStack.rightAnchor.constraint(equalTo: homeStoreTabBar.rightAnchor,
                                               constant: Metrics.tabBarStackRightInset)
        ])
        NSLayoutConstraint.activate([
            explorerLabel.widthAnchor.constraint(equalToConstant: Metrics.explorerLabelWidth)
        ])
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        dataSourceConfigure()
        
        // Explorer label setup
        explorerLabel.textAlignment = .left
        
        // showCartButton Action
        showCartButton.addTarget(self, action: #selector(showCart), for: .touchUpInside)
    }
    
    // MARK: - Private Methods
    
    private func makeButton(image: UIImage,
                            action: UIAction) -> UIButton {
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image.withTintColor(.white,
                                            renderingMode: .alwaysOriginal),
                        for: .normal)
        return button
    }
    
    @objc
    private func showCart() {
        coordinator?.showCartView()
    }
}

// MARK: - Extensions

/// CollectionView configure
extension HomeStoreControllerView {
        
    private func dataSourceConfigure() {
        dataSource = viewModel.collectionViewDataSourceProvider(collectionView: collectionView)
    }
    
    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        viewModel.collectionViewLayoutProvider()
    }
}

/// Collection view delegate
extension HomeStoreControllerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItemHighlighting(collectionView: collectionView,
                                         indexPath: indexPath)
    }
}

/// Metrics and Strings
extension HomeStoreControllerView {
    enum Metrics {
        static let explorerLabelTextSize: CGFloat = 15
        static let tabBarStackLeftInset: CGFloat = 67
        static let tabBarStackRightInset: CGFloat = -42
        static let explorerLabelWidth: CGFloat = 90
    }
    enum Strings {
        static let explorerLabelText = "Explorer"
    }
}

