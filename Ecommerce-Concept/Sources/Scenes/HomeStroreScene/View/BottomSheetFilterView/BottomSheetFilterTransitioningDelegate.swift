//
//  BottomSheetFilterTransitioningDelegate.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 26.12.2022.
//

import UIKit

final class BottomSheetFilterTransitioningDelegate: NSObject,
                                                    UIViewControllerTransitioningDelegate {
    // MARK: - Properties
    
    weak var viewModel: BottomSheetFilterpresentationControllerViewModelType!
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = BottomSheetFilterPresentationController(presentedViewController: presented,
                                                                             presenting: presenting ?? source,
                                                                             viewModel: viewModel)
        return presentationController
    }
}


