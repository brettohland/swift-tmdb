// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

@preconcurrency import PackageDescription

let package = Package(
    name: "TMDBSwifty",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .macCatalyst(.v15),
        .tvOS(.v15),
    ],
    products: [
        .library(
            name: "TMDBSwifty",
            targets: ["TMDB"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", exact: "1.10.0"),
    ],
    targets: [
        .target(
            name: "TMDB",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
            ],
            resources: [
                .process("Services/MockingService/JSON"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
                .enableUpcomingFeature("InferIsolatedConformances"),
                .enableUpcomingFeature("FullTypedThrows"),
            ],
        ),
        .testTarget(name: "TMDBTests", dependencies: ["TMDB"]),
    ],
)
