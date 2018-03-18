//
//  Logger.swift
//  Logger
//
//  Created by Jordan.Dixon on 12/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import Foundation

// MARK: - Logger
public final class Logger {

    /// Determines whether the view controller to view logs can be displayed. If false, the view controller will not be presented even if you call the function
    public static var canBeDisplayed = false

    /// Deletes the current log file
    public static func deleteLog() {
        Constants.logPath.delete()
    }

    /// Determines how logging should occour. Defaults to .print. Set to .none to disable all logging.
    static var logType: LogType = .print

    /// The name of the log file. Logger will append a .txt extension for you
    static var logFileName = "debugLog"

    public static func setup(logType: LogType, fileName: String) {
        Logger.logType = logType
        Logger.logFileName = fileName
    }

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy HH:mm"
        return formatter
    }()

    static var currentDate: String {
        return Logger.dateFormatter.string(from: Date())
    }

    static var textLogger = TextOutputManager()

}

// MARK: - View Presentation
extension Logger {

    private static func presentedViewController(from vc: UIViewController?) -> UIViewController? {
        if let presented = vc?.presentedViewController {
            if presented is UIAlertController { return vc }
            return presentedViewController(from: presented)
        }
        return vc
    }

    /// Presents the view controller to view the logs on top of the currently presented view controller
    public static func present(onto vc: UIViewController?, version: String, build: String, tint: UIColor = .black) {
        let presentedVC = presentedViewController(from: vc)
        if !Logger.canBeDisplayed || presentedVC is ViewLogViewController { return }

        let logVC = ViewLogViewController(version: version, build: build, tint: tint)
        logVC.modalPresentationStyle = .custom
        logVC.transitioningDelegate = logVC
        presentedVC?.present(logVC, animated: true, completion: nil)
    }
}
