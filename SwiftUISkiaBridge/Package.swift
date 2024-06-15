// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "SwiftUISkiaBridge",
	products: [
		.library(
			name: "SwiftUISkiaBridge",
			targets: ["SwiftUISkiaBridge"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "SwiftUISkiaBridge",
			dependencies: ["RustXcframework"])
	]
)
	