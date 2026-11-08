// swift-tools-version:6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HealthHub",
    platforms: [.iOS(.v27)],
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
            resources: [.process("Resources")]
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
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("InferIsolatedConformances")
  ])
  target.swiftSettings = settings
}
