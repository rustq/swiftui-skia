// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "SoftSkiaSwift",
	products: [
		.library(
			name: "SoftSkiaSwift",
			targets: ["SoftSkiaSwift"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "SoftSkiaSwift",
			dependencies: ["RustXcframework"])
	]
)
	