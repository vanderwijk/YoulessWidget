// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "YoulessWidget",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .iOSApplication(
            name: "YoulessWidget",
            targets: ["YoulessWidget"]
        ),
        .iOSApplication(
            name: "YoulessWidgetWidgetExtension",
            targets: ["YoulessWidgetWidgetExtension"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "YoulessWidget",
            dependencies: []
        ),
        .target(
            name: "YoulessWidgetWidgetExtension",
            dependencies: []
        ),
        .testTarget(
            name: "YoulessWidgetTests",
            dependencies: ["YoulessWidget"]
        ),
        .testTarget(
            name: "YoulessWidgetWidgetExtensionTests",
            dependencies: ["YoulessWidgetWidgetExtension"]
        )
    ]
)