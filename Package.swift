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
        .library(name: .tmdb, targets: [.tmdb]),
    ],
    dependencies: [
        .swiftDependencies,
    ],
    targets: [
        .mocks,
        .requestService,
        .sharedModels,
        .tmdb,
        .utilities,

        .tmdbTests,
    ],
)

extension String {
    static let tmdb = "TMDB"
}

enum TargetNames {
    static let dependencies = "Dependencies"
    static let requestService = "RequestService"
    static let tmdb = "TMDB"
    static let tmdbTests = "TMDBTests"
    static let utilities = "Utilities"
    static let sharedModels = "SharedModels"
    static let mocks = "Mocks"
}

// MARK: -  Target Definitions

extension Target {
    static let mocks = target(
        name: TargetNames.mocks,
        dependencies: [
            Dependency.Internal.sharedModels,
        ],
        resources: [
            .process("JSON")
        ]
    )
    static let requestService = target(
        name: TargetNames.requestService,
        dependencies: [
            Dependency.Internal.sharedModels,
            Dependency.Internal.utilities,
        ],
    )
    static let sharedModels = target(
        name: TargetNames.sharedModels,
        dependencies: [
            // NO INTERNAL DEPENDENCIES!
            Dependency.External.swiftDependencies,
            Dependency.External.swiftDependenciesMacros,
        ],
    )
    static let tmdb = target(
        name: TargetNames.tmdb,
        dependencies: [
            Dependency.Internal.mocks,
            Dependency.Internal.sharedModels,
            Dependency.Internal.requestService,
            Dependency.Internal.utilities,
            Dependency.External.swiftDependencies,
            Dependency.External.swiftDependenciesMacros,
        ],
    )
    static let utilities = target(
        name: TargetNames.utilities,
        dependencies: [
            // NO INTERNAL DEPENDENCIES!
            Dependency.External.swiftDependencies,
        ],
    )
}

// MARK: - Test Targets

extension Target {
    static let tmdbTests = testTarget(
        name: TargetNames.tmdbTests,
        dependencies: [
            Dependency.Internal.mocks,
            Dependency.Internal.tmdb,
            Dependency.Internal.sharedModels,
            Dependency.External.swiftDependencies,
        ]
    )
}

extension Target.Dependency {
    enum Internal {
        static let requestService = Target.Dependency.target(name: TargetNames.requestService)
        static let sharedModels = Target.Dependency.target(name: TargetNames.sharedModels)
        static let tmdb = Target.Dependency.target(name: TargetNames.tmdb)
        static let utilities = Target.Dependency.target(name: TargetNames.utilities)
        static let mocks = Target.Dependency.target(name: TargetNames.mocks)
    }

    // External Dependencies
    enum External {
        static let swiftDependencies = Target.Dependency.product(
            name: "Dependencies",
            package: "swift-dependencies",
        )
        static let swiftDependenciesMacros = Target.Dependency.product(
            name: "DependenciesMacros",
            package: "swift-dependencies",
        )
    }
}

extension Package.Dependency {
    static let swiftDependencies = Package.Dependency.package(
        url: "https://github.com/pointfreeco/swift-dependencies.git",
        exact: "1.10.0",
    )
}

extension Resource {
    static let resources = process("Resources")
}
