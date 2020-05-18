//
//  SavedPathsManager.swift
//  SymbolsUploader
//
//  Created by Joshua Moore on 5/14/20.
//  Copyright © 2020 Joshua Moore. All rights reserved.
//

import Foundation
import SwiftUI

class SavedPathsManager {
    static func save(directory: String, type: DirectoryType) {
        UserDefaults.standard.set(directory, forKey: type.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func fetchSavedDirectories() -> PathPair {
        let plistPath = UserDefaults.standard.string(forKey: DirectoryType.plist.rawValue)
        let dsymPath = UserDefaults.standard.string(forKey: DirectoryType.dsym.rawValue)
        return(plistPath ?? "", dsymPath ?? "")
    }

    @discardableResult
    static func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }

}
