// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "YoulessWidget",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .app(name: "YoulessWidget", targets: ["YoulessWidget"]),
        .library(name: "YoulessWidgetLibrary", targets: ["YoulessWidgetLibrary"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "YoulessWidget",
            dependencies: ["YoulessWidgetLibrary"]
        ),
        .target(
            name: "YoulessWidgetLibrary",
            dependencies: []
        ),
        .testTarget(
            name: "YoulessWidgetTests",
            dependencies: ["YoulessWidget"]
        ),
        .testTarget(
            name: "YoulessWidgetUITests",
            dependencies: ["YoulessWidget"]
        ),
    ]
)