//
//  Utils.swift
//  Logger
//
//  Created by Jordan.Dixon on 13/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import UIKit

extension UIView {

    func roundTopTwoCorners(radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.clipsToBounds = true
            UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
                self.layer.cornerRadius = radius
            }.startAnimation()
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }

    func roundAllCorners(radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            self.clipsToBounds = true
            UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
                self.layer.cornerRadius = radius
            }.startAnimation()
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

extension URL {

    @discardableResult
    func delete() -> Bool {

        do {
            if FileManager.default.fileExists(atPath: self.path) {
                try FileManager.default.removeItem(at: self)
                return true
            }
            return false

        } catch { return false }
    }
}
