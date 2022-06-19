//
//  ContentView.swift
//  Shared
//
//  Created by Yusuke Hosonuma on 2022/06/19.
//

import SwiftUI

struct ContentView: View {
    // TODO: ユーザにディレクトリ選択する形式にすれば AppSandox を有効化して公証が取れる（はず）
    @StateObject private var viewModel: FileWatcher = .init(at: "/tmp/ObservableObjectDebugger")

    var body: some View {
        List(viewModel.contents) { data in
            GroupBox {
                Text(colorlized(data.contet))
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .lineSpacing(4)
                    .lineLimit(30) // FIXME: SwiftUI 3.0 on macOS ではテキスト処理が遅すぎて簡単にフリーズする。TextKit などの利用を検討すること。
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

        for range in string.ranges(of: "true") {
            string[range].foregroundColor = .purple
        }

        for range in string.ranges(of: "false") {
            string[range].foregroundColor = .purple
        }

        for range in string.ranges(of: "nil") {
            string[range].foregroundColor = .cyan
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

extension AttributedString {
    func ranges<T: StringProtocol>(of stringToFind: T) -> [Range<AttributedString.Index>] {
        var ranges: [Range<AttributedString.Index>] = []
        var substring = self[self.startIndex ..< self.endIndex]
        while let range = substring.range(of: stringToFind) {
        ranges.append(range)
            substring = self[range.upperBound...]
    }
        return ranges
    }
}
