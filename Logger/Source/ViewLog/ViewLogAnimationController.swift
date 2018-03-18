//
//  ViewLogAnimationController.swift
//  Logger
//
//  Created by Jordan.Dixon on 13/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import Foundation

// MARK: - ViewLogAnimationController
class ViewLogAnimationController: NSObject {

    private let isPresenting: Bool

    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
}

extension ViewLogAnimationController: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        var transition: () -> Void

        if isPresenting {

            let presentedViewController = transitionContext.viewController(forKey: .to)!
            let presentedViewControllerView = transitionContext.view(forKey: .to)!

            let finalFrame = transitionContext.finalFrame(for: presentedViewController)
            var initialFrame = transitionContext.initialFrame(for: presentedViewController)
            initialFrame = finalFrame
            initialFrame.origin.y = containerView.bounds.maxY

            presentedViewControllerView.frame = initialFrame

            transition = { presentedViewControllerView.frame = finalFrame }
        } else {
            let presentedViewControllerView = transitionContext.view(forKey: .from)!

            transition = { presentedViewControllerView.frame.origin.y = containerView.bounds.maxY }
        }

        performTransition(transitionContext: transitionContext, transition: transition)
    }

    private func performTransition(transitionContext: UIViewControllerContextTransitioning, transition: @escaping () -> Void) {

        if transitionContext.isAnimated {

            let duration = transitionDuration(using: transitionContext)
            let options: UIViewAnimationOptions = [.curveEaseInOut, .layoutSubviews]
            let completion = { completed in transitionContext.completeTransition(completed) }

            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: options, animations: transition, completion: completion)

        } else {
            transition()
            transitionContext.completeTransition(true)
        }
    }
}
