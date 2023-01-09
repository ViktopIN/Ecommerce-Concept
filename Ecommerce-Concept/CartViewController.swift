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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubviews(backButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.backButtonTopInset),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.backButtonLeadingInset),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.backButtonMainSize),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.backButtonMainSize)
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
        static let backButtonMainSize: CGFloat = 37
    }
    
    enum Strings {
        
    }
}
