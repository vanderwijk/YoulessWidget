// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "YoulessWidget",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "YoulessWidget",
            targets: ["YoulessWidget"]
        ),
        .library(
            name: "YoulessWidgetWidgetExtension",
            targets: ["YoulessWidgetWidgetExtension"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "YoulessWidget",
            path: "Sources/YoulessWidget"
        ),
        .target(
            name: "YoulessWidgetWidgetExtension",
            dependencies: ["YoulessWidget"], // Add dependency on YoulessWidget
            path: "Sources/YoulessWidgetWidgetExtension",
            swiftSettings: [
                .define("PLATFORM_IOS", .when(platforms: [.iOS]))
            ]
        ),
        .testTarget(
            name: "YoulessWidgetTests",
            dependencies: ["YoulessWidget"],
            path: "Tests/YoulessWidgetTests"
        ),
        .testTarget(
            name: "YoulessWidgetWidgetExtensionTests",
            dependencies: ["YoulessWidgetWidgetExtension"],
            path: "Tests/YoulessWidgetWidgetExtensionTests"
        )
    ]
)