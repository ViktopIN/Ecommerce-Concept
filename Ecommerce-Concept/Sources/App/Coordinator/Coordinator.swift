//
//  Coordinator.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 25.12.2022.
//

import UIKit

class Coordinator: CoordinatorProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    // MARK: - Initialise
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        let homeStoreViewController = HomeStoreControllerView()
        homeStoreViewController.coordinator = self
        homeStoreViewController.viewModel = HomeStoreViewModel()
        homeStoreViewController.viewModel.coordinator = self
        navigationController.pushViewController(homeStoreViewController,
                                                animated: false)
    }
    
    func showHomeStoreView() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func showBottomSheetOnHomeStoreView() {
        let homeStoreViewController = navigationController.visibleViewController as? HomeStoreControllerView
        let bottomSheetFilterViewController = BottomSheetFilterControllerView()
        let bottomSheetFilterViewViewModel = BottomSheetFilterViewViewModel()
        let BottomSheetFilterpresentationControllerViewModel = BottomSheetFilterpresentationControllerViewModel()
        let bottomSheetFilterTransitioningDelegate = BottomSheetFilterTransitioningDelegate()
        bottomSheetFilterTransitioningDelegate.viewModel = BottomSheetFilterpresentationControllerViewModel
        bottomSheetFilterViewController.viewModel = bottomSheetFilterViewViewModel
        bottomSheetFilterViewController.transitioningDelegate = bottomSheetFilterTransitioningDelegate
        bottomSheetFilterViewController.modalPresentationStyle = .custom

        homeStoreViewController?.present(bottomSheetFilterViewController, animated: true)
    }
    
    func showProductDetailView() {
        let productDetailViewController = ProductDetailsViewController()
        let productDetailViewViewModel = ProductDetailsViewViewModel()
        productDetailViewController.viewModel = productDetailViewViewModel
        productDetailViewController.coordinator = self
        navigationController.pushViewController(productDetailViewController,
                                                animated: true)
    }
}
