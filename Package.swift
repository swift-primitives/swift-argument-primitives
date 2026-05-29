// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-argument-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "Argument Primitive",
            targets: ["Argument Primitive"]
        ),

        // MARK: - Core + Variants
        .library(
            name: "Argument Primitives Core",
            targets: ["Argument Primitives Core"]
        ),
        .library(
            name: "Argument Positional Primitives",
            targets: ["Argument Positional Primitives"]
        ),
        .library(
            name: "Argument Option Primitives",
            targets: ["Argument Option Primitives"]
        ),
        .library(
            name: "Argument Flag Primitives",
            targets: ["Argument Flag Primitives"]
        ),
        .library(
            name: "Argument Group Primitives",
            targets: ["Argument Group Primitives"]
        ),
        .library(
            name: "Argument Subcommand Primitives",
            targets: ["Argument Subcommand Primitives"]
        ),
        .library(
            name: "Argument Schema Primitives",
            targets: ["Argument Schema Primitives"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Argument Primitives",
            targets: ["Argument Primitives"]
        ),

        // MARK: - Test Support
        .library(
            name: "Argument Primitives Test Support",
            targets: ["Argument Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-tagged-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-text-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-diagnostic-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-parser-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-finite-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-index-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-affine-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-byte-primitives.git", branch: "main"),
    ],
    targets: [
        // MARK: - Namespace
        .target(
            name: "Argument Primitive",
            dependencies: []
        ),

        // MARK: - Core
        .target(
            name: "Argument Primitives Core",
            dependencies: [
                "Argument Primitive",
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
                .product(name: "Text Primitives", package: "swift-text-primitives"),
                .product(name: "Diagnostic Primitives", package: "swift-diagnostic-primitives"),
                .product(name: "Index Primitives", package: "swift-index-primitives"),
                .product(name: "Affine Primitives", package: "swift-affine-primitives"),
                .product(name: "Byte Primitives", package: "swift-byte-primitives"),
            ]
        ),

        // MARK: - Combinator Variants
        .target(
            name: "Argument Positional Primitives",
            dependencies: [
                "Argument Primitives Core",
                .product(name: "Parser Primitives Core", package: "swift-parser-primitives"),
            ]
        ),
        .target(
            name: "Argument Option Primitives",
            dependencies: [
                "Argument Primitives Core",
                .product(name: "Parser Primitives Core", package: "swift-parser-primitives"),
            ]
        ),
        .target(
            name: "Argument Flag Primitives",
            dependencies: [
                "Argument Primitives Core",
                .product(name: "Parser Primitives Core", package: "swift-parser-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
            ]
        ),
        .target(
            name: "Argument Group Primitives",
            dependencies: [
                "Argument Primitives Core",
                .product(name: "Parser Primitives Core", package: "swift-parser-primitives"),
            ]
        ),
        .target(
            name: "Argument Subcommand Primitives",
            dependencies: [
                "Argument Primitives Core",
                .product(name: "Parser Primitives Core", package: "swift-parser-primitives"),
            ]
        ),

        // MARK: - Schema (composes all combinators)
        .target(
            name: "Argument Schema Primitives",
            dependencies: [
                "Argument Primitives Core",
                "Argument Positional Primitives",
                "Argument Option Primitives",
                "Argument Flag Primitives",
                "Argument Group Primitives",
                "Argument Subcommand Primitives",
                .product(name: "Parser Primitives Core", package: "swift-parser-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Argument Primitives",
            dependencies: [
                "Argument Primitive",
                "Argument Primitives Core",
                "Argument Positional Primitives",
                "Argument Option Primitives",
                "Argument Flag Primitives",
                "Argument Group Primitives",
                "Argument Subcommand Primitives",
                "Argument Schema Primitives",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Argument Primitives Test Support",
            dependencies: [
                "Argument Primitives",
                .product(name: "Tagged Primitives Test Support", package: "swift-tagged-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Argument Primitives Core Tests",
            dependencies: ["Argument Primitives Test Support"]
        ),
        .testTarget(
            name: "Argument Positional Primitives Tests",
            dependencies: ["Argument Primitives Test Support"]
        ),
        .testTarget(
            name: "Argument Option Primitives Tests",
            dependencies: ["Argument Primitives Test Support"]
        ),
        .testTarget(
            name: "Argument Flag Primitives Tests",
            dependencies: ["Argument Primitives Test Support"]
        ),
        .testTarget(
            name: "Argument Group Primitives Tests",
            dependencies: ["Argument Primitives Test Support"]
        ),
        .testTarget(
            name: "Argument Subcommand Primitives Tests",
            dependencies: ["Argument Primitives Test Support"]
        ),
        .testTarget(
            name: "Argument Schema Primitives Tests",
            dependencies: ["Argument Primitives Test Support"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
