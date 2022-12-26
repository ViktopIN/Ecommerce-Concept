//
//  BottomSheetFilterpresentationControllerViewModelType.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 25.12.2022.
//

import UIKit

protocol BottomSheetFilterpresentationControllerViewModelType: AnyObject {
    func handlePan(gesture: UIPanGestureRecognizer,
                   interactor: UIPercentDrivenInteractiveTransition,
                   containerView: UIView?,
                   presentedViewController: UIViewController)
}
