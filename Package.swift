// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let settings: [SwiftSetting] = [
    .swiftLanguageMode(.v6)
]

let package = Package(
    name: "MBHealthTracker",
    platforms: [.iOS("17.0")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MBHealthTracker",
            targets: ["MBHealthTracker"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MBHealthTracker",
            dependencies: [],
            path: "Sources",
            swiftSettings: settings
        ),
        .testTarget(
            name: "MBHealthTrackerTests",
            dependencies: ["MBHealthTracker"],
            path: "Tests/UnitTests"
        ),
    ]
)
