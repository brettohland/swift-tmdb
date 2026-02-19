// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

@preconcurrency import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("FullTypedThrows"),
]

let package = Package(
    name: "swift-tmdb",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .macCatalyst(.v26),
        .tvOS(.v26),
    ],
    products: [
        .library(
            name: "TMDB",
            targets: ["TMDB", "TMDBMocking"],
        ),
        .library(
            name: "TMDBCore",
            targets: ["TMDB"],
        ),
        .library(
            name: "TMDBDependencies",
            targets: ["TMDBDependencies"],
        ),
        .library(
            name: "TMDBSwiftUI",
            targets: ["TMDBSwiftUI"],
        ),
        .library(
            name: "TMDBUIKit",
            targets: ["TMDBUIKit"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", exact: "1.10.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "TMDB",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
            ],
            swiftSettings: swiftSettings,
        ),
        .target(
            name: "TMDBMocking",
            dependencies: ["TMDB"],
            resources: [
                .process("JSON"),
            ],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "TMDBDependencies",
            dependencies: [
                "TMDB",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
            ],
            swiftSettings: swiftSettings,
        ),
        .target(
            name: "TMDBSwiftUI",
            dependencies: ["TMDB"],
            swiftSettings: swiftSettings,
        ),
        .target(
            name: "TMDBUIKit",
            dependencies: ["TMDB"],
            swiftSettings: swiftSettings,
        ),
        .testTarget(
            name: "TMDBTests",
            dependencies: [
                "TMDB",
                "TMDBMocking",
                .product(name: "Dependencies", package: "swift-dependencies"),
            ],
            swiftSettings: swiftSettings
        ),
    ],
)
