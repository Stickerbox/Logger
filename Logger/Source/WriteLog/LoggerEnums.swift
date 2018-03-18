//
//  LoggerEnums.swift
//  Logger
//
//  Created by Jordan.Dixon on 13/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import Foundation

public enum LogLevel: String {
    case none = ""
    case debug = "💚"
    case info = "💙"
    case warning = "💛"
    case verbose = "🧡"
    case error = "💔"

    var uppercased: String {
        return "\(self.rawValue) \(String(describing: self).uppercased()) \(self.rawValue)"
    }
}

public enum LogType {
    case none, print, toFile, both
}
