// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ObservableObjectDebugger",
    products: [
        .library(name: "ObservableObjectDebugger", targets: ["ObservableObjectDebugger"]),
    ],
    dependencies: [
        .package(url: "https://github.com/YusukeHosonuma/SwiftPrettyPrint.git", from: "1.4.0"),
    ],
    targets: [
        .target(name: "ObservableObjectDebugger", dependencies: [
            "SwiftPrettyPrint"
        ]),
        .testTarget(name: "ObservableObjectDebuggerTests", dependencies: ["ObservableObjectDebugger"]),
    ]
)
