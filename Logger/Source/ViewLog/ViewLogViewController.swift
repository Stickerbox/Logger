//
//  ViewLogViewController.swift
//  Logger
//
//  Created by Jordan.Dixon on 13/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import UIKit

/// Call Logger.present(onto:) to present this view controller
class ViewLogViewController: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var visibleView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    var version = "Unknown"
    var build = "Unknown"
    var tintColor: UIColor

    init(version: String, build: String, tint: UIColor) {
        self.version = version
        self.build = build
        self.tintColor = tint

        let resourcesBundle = Bundle(identifier: "com.mubaloo.Logger")
        super.init(nibName: "ViewLogViewController", bundle: resourcesBundle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewDidTap)))
        if UIDevice.current.userInterfaceIdiom == .pad {
            topConstraint.constant = 50
        }
        visibleView.roundTopTwoCorners(radius: 20)
        versionLabel.text = "Version: " + version
        buildLabel.text = "Build: " + build
        versionLabel.textColor = tintColor
        buildLabel.textColor = tintColor
        doneButton.setTitleColor(tintColor, for: .normal)
        doneButton.roundAllCorners(radius: 15)

        logTextView.text = try? String(contentsOf: Constants.logPath, encoding: .utf8)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let stringLength = logTextView.text.count
        logTextView.scrollRangeToVisible(NSRange(location: stringLength - 1, length: 0))
    }

    @objc func viewDidTap(r: UITapGestureRecognizer) {
        let location = r.location(in: visibleView)
        if !visibleView.bounds.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }

}

// MARK: - Dismissal
extension ViewLogViewController {

    @IBAction func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func shareButtonTapped() {
        let shareSheet = UIActivityViewController(activityItems: [logTextView.text], applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            shareSheet.popoverPresentationController?.sourceView = shareButton
        }
        present(shareSheet, animated: true, completion: nil)
    }

    @IBAction func clearButtonTapped() {
        let alert = UIAlertController(title: "Clear Logs", message: "All logs will be cleared. Continue?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .destructive) { _ in
            self.logTextView.text = ""
            Logger.deleteLog()
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - Transistioning
extension ViewLogViewController: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ViewLogPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewLogAnimationController(isPresenting: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewLogAnimationController(isPresenting: false)
    }
}
