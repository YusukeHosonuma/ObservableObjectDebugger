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

3. Build and launch the [Viewer app](https://github.com/YusukeHosonuma/ObservableObjectDebugger/tree/main/Viewer/ObservableObjectViewer.xcodeproj) or reference to folder `/tmp/ObservableObjectDebugger` (with VSCode and others).

<img width="1178" alt="image" src="https://user-images.githubusercontent.com/2990285/174471452-a5955c3d-694f-413e-9860-8fc994c45f48.png">

<img width="1151" alt="image" src="https://user-images.githubusercontent.com/2990285/174471479-2b1969d1-af31-4632-8a88-cfbb7097476d.png">

## Requirements

- iOS 14+ (**Simulator only**)
- macOS 12+ (Viewer app)

## Author

Yusuke Hosonuma / [@tobi462](https://twitter.com/tobi462)
