//
//  TextLog.swift
//  Logger
//
//  Created by Jordan.Dixon on 12/03/2018.
//  Copyright © 2018 Jordan Dixon. All rights reserved.
//

import Foundation

struct TextOutputManager: TextOutputStream {

    /// Appends the given string to the stream.
    mutating func write(_ string: String) {
        let log = Constants.logPath

        do {
            let handle = try FileHandle(forWritingTo: log)
            handle.seekToEndOfFile()
            handle.write(string.data(using: .utf8)!)
            handle.closeFile()
        } catch {
            print(error.localizedDescription)
            do {
                try string.data(using: .utf8)?.write(to: log)
            } catch {
                print(error.localizedDescription)
            }
        }

    }

}
