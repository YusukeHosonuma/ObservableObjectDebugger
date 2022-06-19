//
//  ContentView.swift
//  Shared
//
//  Created by Yusuke Hosonuma on 2022/06/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: FileWatcher = .init(at: "/tmp/ObservableObjectDebugger")

    var body: some View {
        List(viewModel.contents) { data in
            GroupBox {
                Text(colorlized(data.contet))
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .padding(4)
                Spacer(minLength: 0)
            } label: {
                Text(data.name)
                    .font(.subheadline)
            }
            .textSelection(.enabled)
        }
        .task {
            Task {
                try await viewModel.start()
            }
        }
    }

    private func colorlized(_ content: String) -> AttributedString {
        var string = AttributedString(content)

        if let range = string.range(of: "true") {
            string[range].foregroundColor = .red
        }

        if let range = string.range(of: "false") {
            string[range].foregroundColor = .red
        }

        let characters = string.characters
        let indices = characters.indices.filter { characters[$0] == "\"" }

        for (start, end) in indices.chunksByPair() {
            string[start ... end].foregroundColor = .orange
        }

        return string
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
