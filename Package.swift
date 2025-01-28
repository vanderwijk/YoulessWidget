// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "YoulessWidget",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "YoulessWidget",
            targets: ["YoulessWidget"]
        ),
        .library(
            name: "YoulessWidgetExtension",
            targets: ["YoulessWidgetExtension"]
        )
    ],
    dependencies: [
        .package(name: "WidgetKit", type: .framework)
    ],
    targets: [
        .target(
            name: "YoulessWidget",
            dependencies: ["WidgetKit"],
            path: "Sources/YoulessWidget"
        ),
        .target(
            name: "YoulessWidgetExtension",
            dependencies: ["YoulessWidget", "WidgetKit"],
            path: "Sources/YoulessWidgetExtension"
        ),
        .testTarget(
            name: "YoulessWidgetTests",
            dependencies: ["YoulessWidget"]
        )
    ]
)