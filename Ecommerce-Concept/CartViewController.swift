//
//  CartViewController.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 09.01.2023.
//

import UIKit

class CartViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: CoordinatorProtocol!
    
    // MARK: - Views
    
    private lazy var backButton = CustomButton(internalObject: nil,
                                               objectColor: nil,
                                               backgroundView: .roundedCorner(color: .customDarkBlue),
                                               isBackButton: true)
    private var addAddressButton = CustomButton(internalObject: UIImage(named: "addAddress"),
                                                objectColor: .white,
                                                backgroundView: .roundedCorner(color: .customOrange))
    private lazy var addAddressLabel = UILabel(constant: Strings.addAddressLabelText,
                                              with: Metrics.addAddressLabelTextSize,
                                              and: .medium, .customDarkBlue)
    private lazy var cartTitleLabel = UILabel(constant: Strings.cartTitleLabelText,
                                              with: Metrics.cartTitleLabelTextSize,
                                              and: .bold, .customDarkBlue)
    private lazy var cartContainerView = UIView(background: .customDarkBlue,
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
        view.addSubviews(backButton,
                         addAddressButton,
                         addAddressLabel,
                         cartTitleLabel,
                         cartContainerView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // MARK: backButton constraints
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.backButtonTopInset),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.backButtonLeadingInset),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.titleButtonsMainSize),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.titleButtonsMainSize),
            
            // MARK: addAddressButton constraints
            addAddressButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addAddressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Metrics.addAddressButtonTrailingInset),
            addAddressButton.heightAnchor.constraint(equalToConstant: Metrics.titleButtonsMainSize),
            addAddressButton.widthAnchor.constraint(equalToConstant: Metrics.titleButtonsMainSize),
            
            // MARK: addAddressLabel constraints
            addAddressLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addAddressLabel.trailingAnchor.constraint(equalTo: addAddressButton.leadingAnchor, constant: Metrics.addAddressLabelTrailingInset),
            addAddressLabel.heightAnchor.constraint(equalToConstant: Metrics.addAddressLabelHeight),
            addAddressLabel.widthAnchor.constraint(equalToConstant: Metrics.returnLabelsWidth(text: addAddressLabel.text!,
                                                                                              with: 11,
                                                                                              and: .markProMedium(ofSize: Metrics.addAddressLabelTextSize))),
            // MARK: cartTitleLabel constraints
            cartTitleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.cartTitleLabelTopInset),
            cartTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.cartTitleLabelLeadingInset),
            cartTitleLabel.heightAnchor.constraint(equalToConstant: Metrics.cartTitleLabelHeight),
            cartTitleLabel.widthAnchor.constraint(equalToConstant: Metrics.returnLabelsWidth(text: cartTitleLabel.text!,
                                                                                             with: Metrics.cartTitleLabelHeight, 
                                                                                             and: .markProBold(ofSize: Metrics.cartTitleLabelTextSize))),
            // MARK: cartContainerView constraints
            cartContainerView.topAnchor.constraint(equalTo: cartTitleLabel.bottomAnchor, constant: Metrics.cartContainerViewTopInset),
            cartContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupView() {
        // view setup
        view.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        // backButton setup
        backButton.setupBackButton(viewControllersCoordinator: coordinator)
    }
}

extension CartViewController {
    enum Metrics {
        static let backButtonTopInset: CGFloat = 79
        static let backButtonLeadingInset: CGFloat = 42
        static let titleButtonsMainSize: CGFloat = 37
        
        static let addAddressButtonTrailingInset: CGFloat = -48
        
        static let addAddressLabelTextSize: CGFloat = 15
        static let addAddressLabelTrailingInset: CGFloat = -9
        static let addAddressLabelHeight: CGFloat = 19
        
        static let cartTitleLabelTextSize: CGFloat = 35
        static let cartTitleLabelTopInset: CGFloat = 50
        static let cartTitleLabelLeadingInset: CGFloat = 42
        static let cartTitleLabelHeight: CGFloat = 44
        
        static let cartContainerViewTopInset: CGFloat = 49
        
        static func returnLabelsWidth(text: String,
                                      with constrainedHeight: CGFloat,
                                      and font: UIFont) -> CGFloat {
            return text.width(withConstrainedHeight: constrainedHeight, font: font)
        }
        
    }
    
    enum Strings {
        static let addAddressLabelText = "Add address"
        static let cartTitleLabelText = "Cart"
    }
}
