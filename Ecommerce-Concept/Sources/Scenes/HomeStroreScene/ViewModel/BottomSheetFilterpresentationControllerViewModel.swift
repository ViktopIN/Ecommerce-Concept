//
//  BottomSheetFilterpresentationControllerViewModel.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 25.12.2022.
//

import UIKit

class BottomSheetFilterpresentationControllerViewModel: BottomSheetFilterpresentationControllerViewModelType {
    
    func handlePan(gesture: UIPanGestureRecognizer,
                   interactor: UIPercentDrivenInteractiveTransition,
                   containerView: UIView?,
                   presentedViewController: UIViewController) {
        guard let containerView = containerView else { return }
        
        
        let percent = gesture.translation(in: containerView).y / containerView.bounds.height
        switch gesture.state {
        case .began:
            if !presentedViewController.isBeingDismissed {
                presentedViewController.dismiss(animated: true)
            }
        case .changed:
            interactor.update(percent)
        case .cancelled:
            interactor.cancel()
        case .ended:
            let velocity = gesture.velocity(in: containerView).y
            interactor.completionSpeed = 0.9
            if percent > 0.3 || velocity > 1600 {
                interactor.finish()
            } else {
                interactor.cancel()
            }
        default:
            break
        }

    }
}
