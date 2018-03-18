//
//  Logging.swift
//  Logger
//
//  Created by Jordan.Dixon on 13/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import Foundation

// MARK: - Public Logging

// EXAMPLE: log("Details you want")
// EXAMPLE: log("Changing the level will add meta-data", level: .debug)
/// Logs whatever passed into its first parameter. If 'level' is anything other than .none, meta-data will also be logged
public func log(_ details: @autoclosure () -> Any,
                level: LogLevel = .none,
                file: String = #file, function: String = #function, line: Int = #line) {

    if Logger.logType == .none { return }

    // Don't log any meta-data, just the details passed in
    if level == .none {
        log(message: details)
        return
    }

    let sourceFileComponents = file.components(separatedBy: "/")
    let sourceFile = sourceFileComponents.isEmpty ? "" : sourceFileComponents.last!

    var debugOutput =
    """

    -------------------------
    Level: \(level.uppercased)
    Date: \(Logger.currentDate)
    File: \(sourceFile)
    Function: \(function)
    Line: \(line)

    """
    debugOutput.append("Details: \(details())\n")
    debugOutput.append("-------------------------")

    write(debugOutput)
}

// MARK: - Private Logging

/// Logs the date and message on a single line
private func log(message: @autoclosure () -> Any) {
    write(Logger.currentDate + ": " + String(describing: message()))
}

/// Actually decides how the message should be logged
private func write(_ message: String) {
    switch Logger.logType {
    case .print: print(message)
    case .toFile: Logger.textLogger.write("\n" + message)
    case .both:
        print(message)
        Logger.textLogger.write("\n" + message)
    case .none: break
    }
}
