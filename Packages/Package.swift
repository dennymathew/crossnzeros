// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "CNZViews",
            targets: ["CNZViews"]),
        .library(
            name: "CNZModels",
            targets: ["CNZModels"]),
    ],
    targets: [
        .target(name: "CNZViews", dependencies: ["CNZModels"]),
        .target(name: "CNZModels", dependencies: []),
        .testTarget(name: "CNZModelTests", dependencies: ["CNZModels"]),
    ]
)
