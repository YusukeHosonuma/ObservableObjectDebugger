//
//  View+.swift
//  ObservableObjectDebugger
//
//  Created by Yusuke Hosonuma on 2022/06/19.
//

import Foundation
import OSLog

private let logger = Logger(subsystem: "tech.penginmura.ObservableObjectDebugger", category: "Common")

final class ObservableObjectWriter {
    private let directory: URL

    init(directory: URL) {
        self.directory = directory

        do {
            try FileManager().recreateDirectory(at: directory)
        } catch {
            logger.error("Failed to recreate directory. (\(error.localizedDescription))")
        }
    }

    func write(filename: String, string: String) {
        do {
            let path = directory.path + "/" + filename + ".swift" // TODO: パスは`join`みたいな専用APIで結合したほうがベター
            try string.write(toFile: path, atomically: false, encoding: .utf8)
        } catch {
            logger.error("Failed to write. (\(error.localizedDescription))")
        }
    }
}

private extension FileManager {
    func recreateDirectory(at path: URL) throws {
        if fileExists(atPath: path.path) {
            try removeItem(at: path)
        }
        try createDirectory(at: path, withIntermediateDirectories: true)
    }
}
