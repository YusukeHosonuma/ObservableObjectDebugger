# Observable Object Debugger

Watch for `ObservableObject` in real time. (This is the **Alpha** version)

## Quick Start

1. Add package to you project.

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/YusukeHosonuma/ObservableObjectDebugger.git", branch: "main"),
    ],
    targets: [
        .target(name: "<your-target>", dependencies: [
             "ObservableObjectDebugger",
        ]),
    ]
)
```

2. Add `debugObserve` modifier to any View.

```swift
import ObservableObjectDebugger // ✅ Add import

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel = .init()

    var body: some View {
        Text("Hello")
            .debugObserve(viewModel) // ✅ You can specify any `ObservableObject`.
    }
}
```

3. Build and launch the [Viewer app](https://github.com/YusukeHosonuma/ObservableObjectDebugger/tree/main/Viewer/ObservableObjectViewer.xcodeproj).

## Requirements

- iOS 14+
- macOS 12+ (Viewer app)

## Author

Yusuke Hosonuma / [@tobi462](https://twitter.com/tobi462)
