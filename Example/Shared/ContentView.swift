//
//  ContentView.swift
//  Shared
//
//  Created by Yusuke Hosonuma on 2022/06/19.
//

import SwiftUI
import ObservableObjectDebugger

enum Flavor: String, CaseIterable, Identifiable {
    case chocolate
    case vanilla
    case strawberry

    var id: String { self.rawValue }
}

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel = .init()

    var body: some View {
        VStack {
            TextField("Text", text: $viewModel.text)
            Toggle("Toggle", isOn: $viewModel.bool)
            Picker("Flavor", selection: $viewModel.selectedFlavor) {
                Text("Chocolate 🍫")
                    .tag(Flavor.chocolate)
                Text("Vanilla 🍦")
                    .tag(Flavor.vanilla)
                Text("Strawberry 🍓")
                    .tag(Flavor.strawberry)
            }
        }
        .padding()
        .debugObserve(name: "ContentViewModel", viewModel)
    }
}

class ContentViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var bool = false
    @Published var selectedFlavor = Flavor.chocolate

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
