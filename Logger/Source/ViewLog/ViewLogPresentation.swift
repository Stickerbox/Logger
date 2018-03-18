//
//  ViewLogPresentation.swift
//  Logger
//
//  Created by Jordan.Dixon on 13/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import UIKit

class ViewLogPresentationController: UIPresentationController {

    /// Holds all the views but has its background color set
    private weak var presentedBackgroundView: UIView!
    /// Container for snapshot which is scaled to give zoomed out effect
    private weak var presentingSnapshotViewContainer: UIView!
    /// Snapshot of whatever was behind the presented view. This has its frame offset slightly to remove the extension of the navbar color over the status bar.
    private weak var presentingSnapshotView: UIView!

    override func presentationTransitionWillBegin() {
        let backgroundView = UIView(frame: containerView!.bounds)
        backgroundView.backgroundColor = .black

        let behindContainer = UIView(frame: backgroundView.bounds)
        behindContainer.clipsToBounds = true

        // Take a copy of the current window to show
        let behind = presentingViewController.view.snapshotView(afterScreenUpdates: true)
        behind?.frame = behindContainer.bounds

        behindContainer.addSubview(behind!)
        backgroundView.addSubview(behindContainer)

        containerView?.addSubview(backgroundView)
        containerView?.addSubview(presentedView!)

        presentedBackgroundView = backgroundView
        presentingSnapshotViewContainer = behindContainer
        presentingSnapshotView = behind

        animateAlongSidePresentingTransitionCoordinator {
            self.presentingSnapshotViewContainer.alpha = 0.6
            // Shrink to "Zoom out"
            self.presentingSnapshotViewContainer.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            if UIDevice.current.userInterfaceIdiom == .pad {
                self.presentingSnapshotViewContainer.roundAllCorners(radius: 20)
            } else {
                self.presentingSnapshotViewContainer.roundTopTwoCorners(radius: 20)
            }

            // Clip to remove status bar extension
            self.presentingSnapshotView.frame = self.presentingSnapshotViewContainer.bounds.offsetBy(dx: 0, dy: -UIApplication.shared.statusBarFrame.maxY)
        }
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            presentedBackgroundView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin() {
        animateAlongSidePresentingTransitionCoordinator {
            self.presentingSnapshotView.frame = self.presentingSnapshotViewContainer.bounds
            self.presentingSnapshotViewContainer.alpha = 1
            self.presentingSnapshotViewContainer.transform = .identity
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            presentedBackgroundView.removeFromSuperview()
        }
    }

    override var shouldRemovePresentersView: Bool { return true }

    override var shouldPresentInFullscreen: Bool { return false }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        _ = coordinator.animate(alongsideTransition: { (_) in
            self.presentedBackgroundView.frame = self.containerView!.bounds
        }, completion: nil)

    }

    private func animateAlongSidePresentingTransitionCoordinator(animation: @escaping () -> Void) {

        if let transitionCoordinator = presentingViewController.transitionCoordinator {
            _ = transitionCoordinator.animate(alongsideTransition: { (_) in
                animation()
            }, completion: nil)

        } else {
            animation()
        }
    }
}
