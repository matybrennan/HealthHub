// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
            path: "Sources"
        ),
        .testTarget(
            name: "HealthHubTests",
            dependencies: ["HealthHub"],
            path: "Tests/UnitTests"
        ),
    ]
)

for target in package.targets {
  var settings = target.swiftSettings ?? []
  settings.append(contentsOf: [
    .defaultIsolation(MainActor.self),
//    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
//    .enableUpcomingFeature("InferIsolatedConformances")
  ])
  target.swiftSettings = settings
}
