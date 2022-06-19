//
//  FileWatcher.swift
//  ObservableObjectViewer
//
//  Created by Yusuke Hosonuma on 2022/06/19.
//

import OSLog
import SwiftUI

private let logger = Logger(subsystem: "tech.penginmura.ObservableObjectViewer", category: "Common")

@MainActor
class FileWatcher: ObservableObject {
    let directory: String

    @Published var contents: [ObjectData] = []

    nonisolated init(at directory: String) {
        self.directory = directory
    }

    func start() async throws {
        while true {
            try await Task.sleep(milliseconds: 1000)
            reload()
        }
    }

    private func reload() {
        do {
            // TODO: ファイル読み込みとかはバックグラウンドスレッドで処理したほうがベターかも
            let files = try FileManager.default.contentsOfDirectory(atPath: directory)

            contents = try files
                .filter { $0.hasPrefix(".") == false }
                .map {
                    let path = directory + "/" + $0
                    let content = try String(contentsOfFile: path)

                    let data = ObjectData(
                        name: $0,
                        contet: content
                    )
                    return data
                }
        } catch {
            logger.error("Failed to reload (\(error.localizedDescription))")
        }
    }
}

struct ObjectData: Identifiable {
    var id: String { name }

    var name: String
    var contet: String
}

#if DEBUG
extension ObjectData {
    static let example: [Self] = [
        .init(
            name: "ContentViewModel",
            contet: """
            ContentViewModel(
                text: "Hello world",
                bool: true
            )
            """
        ),
    ]
}
#endif
