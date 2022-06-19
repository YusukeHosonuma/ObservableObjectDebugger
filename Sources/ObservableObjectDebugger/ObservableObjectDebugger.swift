//
//  ObservableObjectWriter.swift
//  ObservableObjectDebugger
//
//  Created by Yusuke Hosonuma on 2022/06/19.
//

import SwiftUI
import SwiftPrettyPrint

private let path: URL = .init(fileURLWithPath: "/tmp/ObservableObjectDebugger")
private let writer = ObservableObjectWriter(directory: path)

public extension View {
    func debugObserve(name: String? = nil, _ object: Any) -> some View {
        var output: String = ""

        Pretty.prettyPrint(object, to: &output)
        output.removeLast()

        let filename = name ?? String(describing: type(of: object))
        writer.write(filename: filename, string: output)
        return self
    }
}
