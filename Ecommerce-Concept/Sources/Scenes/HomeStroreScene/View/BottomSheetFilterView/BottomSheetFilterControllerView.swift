//
//  BottomSheetFilterControllerView.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 24.12.2022.
//

import UIKit

class BottomSheetFilterControllerView: UIViewController {
    
    // MARK: - View and Properties
    
    private lazy var containerView = UIView(background: .white,
                                            cornerType: .rounded)
    private lazy var titleStackView = UIStackView(with: .horizontal,
                                                  layoutMargins: Metrics.titleStackViewLayotMargins)
    private lazy var closeBottomSheetButton = CustomButton(internalObject: UIImage(named: "xmark") ?? UIImage(),
                                                           objectColor: .white,
                                                           backgroundView: .roundedCorner(color: .customDarkBlue))
    private lazy var titleLabel = UILabel(constant: Strings.constantTitleLabelText,
                                          with: Metrics.titleLabelTextSize,
                                          and: .medium,
                                          .customDarkBlue,
                                          adjustFontSizeToFit: false)
    private lazy var doneButton = CustomButton(internalObject: Strings.constantDoneButtonText,
                                               objectColor: .white,
                                               backgroundView: .roundedCorner(color: .customOrange),
                                               textStyle: .smallButtomStyle)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubview(containerView)
        containerView.addSubviews(titleStackView)
        titleStackView.addArrangedSubviews(closeBottomSheetButton, titleLabel, doneButton)
    }
    
    private func setupLayout() {
        containerView.fillSuperview()
        preferredContentSize = CGSize(width: Metrics.screenWidth,
                                      height: Metrics.containerViewHeight)
        view.heightAnchor.constraint(equalToConstant: Metrics.containerViewHeight).isActive = true
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleStackView.heightAnchor.constraint(equalToConstant: Metrics.titleLabelHeight)
        ])
        
        NSLayoutConstraint.activate([
            closeBottomSheetButton.widthAnchor.constraint(equalToConstant: Metrics.closeButtonWidth)
        ])
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: Metrics.titleLabelWidth)
        ])
    }
    
    private func setupView() {
        // view setup
        view.backgroundColor = .clear
        titleLabel.textAlignment = .center
            
        // container view setup
        containerView.layer.shadowColor = UIColor(red: 0.298,
                                                  green: 0.372, 
                                                  blue: 0.562, 
                                                  alpha: 0.2).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 20
        containerView.layer.shadowOffset = CGSize(width: 0,
                                                  height: -5)
        containerView.layer.masksToBounds = false
    }
}

extension BottomSheetFilterControllerView {
    enum Metrics {
        static let containerViewHeight: CGFloat = 335
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let titleStackViewLayotMargins = UIEdgeInsets(top: 24,
                                                             left: 44,
                                                             bottom: 28,
                                                             right: 20)
        static let titleLabelHeight: CGFloat = 90
        static let closeButtonWidth: CGFloat = 37
        static let titleLabelTextSize: CGFloat = 18
        static let titleLabelWidth: CGFloat = 215
    }
    
    enum Strings {
        static let constantTitleLabelText = "Filter options"
        static let constantDoneButtonText = "Done"
    }
}
