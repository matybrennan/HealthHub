// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let settings: [SwiftSetting] = [
    .swiftLanguageMode(.v6),
    .defaultIsolation(MainActor.self)
]

let package = Package(
    name: "HealthHub",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "HealthHub",
            targets: ["HealthHub"]),
    ],
    dependencies: [
        //
    ],
    targets: [
        .target(
            name: "HealthHub",
            dependencies: [],
            path: "Sources",
            swiftSettings: settings
        ),
        .testTarget(
            name: "HealthHubTests",
            dependencies: ["HealthHub"],
            path: "Tests/UnitTests"
        ),
    ]
)
