//
//  BottomSheetFilterPresentationController.swift
//  Ecommerce-Concept
//
//  Created by Виктор on 26.12.2022.
//

import UIKit

final class BottomSheetFilterPresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    var viewModel: BottomSheetFilterpresentationControllerViewModelType!
    private let dimmingView = UIView()
    private let interactor = UIPercentDrivenInteractiveTransition()
    override var frameOfPresentedViewInContainerView: CGRect {
        targetFrameForPresentedView()
    }
    
    // MARK: - Inittialise
    
    init(presentedViewController: UIViewController,
         presenting: UIViewController,
         viewModel: BottomSheetFilterpresentationControllerViewModelType) {
        super.init(presentedViewController: presentedViewController,
                   presenting: presenting)
        self.viewModel = viewModel
    }
    
    // MARK: - Methods
    
    private func targetFrameForPresentedView() -> CGRect {
        guard let containerView = containerView else {
            return .zero
        }
        
        let height = presentedViewController.preferredContentSize.height
        
        return .init(
            x: 0,
            y: (containerView.bounds.height - height),
            width: containerView.bounds.width,
            height: height
        )
    }
    
    override var shouldPresentInFullscreen: Bool {
        false
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerBounds = containerView?.bounds, let presentedView = presentedView else { return }
        
        // Configure the presented view.
        containerView?.addSubview(presentedView)
        presentedView.layoutIfNeeded()
        presentedView.frame = frameOfPresentedViewInContainerView
        dimmingView.frame = containerBounds
        containerView?.insertSubview(dimmingView, at: 0)
        presentedView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:))))
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    @objc
    private func handleDismiss() {
        presentedView?.endEditing(true)
        presentedViewController.dismiss(animated: true)
    }
    
    @objc
    private func handlePan(_ gesture: UIPanGestureRecognizer) {
        viewModel.handlePan(gesture: gesture,
                            interactor: interactor,
                            containerView: containerView,
                            presentedViewController: presentedViewController)
    }
}
