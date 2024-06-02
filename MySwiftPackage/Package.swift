// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "MyCrabLib",
	products: [
		.library(
			name: "MyCrabLib",
			targets: ["MyCrabLib"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "MyCrabLib",
			dependencies: ["RustXcframework"])
	]
)
	