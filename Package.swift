// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftHooksGitHub",
    platforms: [
       .macOS(.v10_14)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "GitHub",
            targets: ["GitHub"]),
    ],
    dependencies: [
        .package(url: "https://github.com/MrLotU/SwiftHooks.git", .branch("master")),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-beta.2.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "GitHub",
            dependencies: ["SwiftHooks", "Vapor"]),
        .testTarget(
            name: "SwiftHooksGitHubTests",
            dependencies: ["GitHub"]),
    ]
)
