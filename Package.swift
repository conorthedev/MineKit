// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MineKit",
    products: [
        .library(
            name: "MineKit",
            targets: ["MineKit"]),
    ],
    dependencies: [
        .package(name: "swift-nio", url: "https://github.com/apple/swift-nio.git", from: Version(2, 16, 0)),
    ],
    targets: [
        .target(
            name: "MineKit",
            dependencies: [
                .product(name: "NIO", package: "swift-nio")
            ]),
        .testTarget(
            name: "MineKitTests",
            dependencies: ["MineKit"]),
    ]
)
