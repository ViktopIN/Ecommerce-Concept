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
    }
    
    private func setupLayout() {
        containerView.fillSuperview()
        preferredContentSize = CGSize(width: Metrics.screenWidth,
                                      height: Metrics.containerViewHeight)
        view.heightAnchor.constraint(equalToConstant: Metrics.containerViewHeight).isActive = true
    }
    
    private func setupView() {
        // view setup
        view.backgroundColor = .clear
            
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
    }
}
