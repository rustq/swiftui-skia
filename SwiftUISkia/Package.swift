// swift-tools-version:5.5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUISkia",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftUISkia",
            targets: ["SwiftUISkia"]),
    ],
    dependencies: [
        .package(name: "SwiftUISkiaBridge", path: "../SwiftUISkiaBridge"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftUISkia",
            dependencies: ["SwiftUISkiaBridge"]),
        .testTarget(
            name: "SwiftUISkiaTests",
            dependencies: ["SwiftUISkia", "SwiftUISkiaBridge"]),
    ]
)
