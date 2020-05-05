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
        .package(name: "swift-nio", url: "https://github.com/apple/swift-nio.git", .upToNextMajor(from: "2.16.0")),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "MineKit",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
            	.product(name: "Logging", package: "swift-log")
	    ]),
        .testTarget(
            name: "MineKitTests",
            dependencies: ["MineKit"]),
    ]
)
