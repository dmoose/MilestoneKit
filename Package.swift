// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "MilestoneKit",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .visionOS(.v2),
    ],
    products: [
        .library(
            name: "MilestoneKit",
            targets: ["MilestoneKit"]
        ),
    ],
    targets: [
        .target(
            name: "MilestoneKit",
            resources: [
                .process("Resources/PrivacyInfo.xcprivacy"),
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("InternalImportsByDefault"),
            ]
        ),
        .testTarget(
            name: "MilestoneKitTests",
            dependencies: ["MilestoneKit"],
            swiftSettings: [
                .swiftLanguageMode(.v6),
            ]
        ),
    ]
)
