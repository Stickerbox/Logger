//
//  Constants.swift
//  Logger
//
//  Created by Jordan.Dixon on 13/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import Foundation

struct Constants {

    static let logFileName = Logger.logFileName + ".txt"

    static var logPath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryPath = paths.first!
        return documentDirectoryPath.appendingPathComponent(logFileName)
    }

}
