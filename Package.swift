// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

@preconcurrency import PackageDescription

let package = Package(
    name: .tmdb,
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
        .tmdb,
        .requestService,
        .utilities,

        .tmdbTests,
    ],
)

extension String {
    static let tmdb = "TMDB"
}


    enum TargetNames {
        static let tmdb = "TMDB"
        static let dependencies = "Dependencies"
        static let requestService = "RequestService"
        static let tmdbTests = "TMDBTests"
        static let utilities = "Utilities"
    }


// MARK: -  Target Definitions

extension Target {
    static let tmdb = target(
        name: TargetNames.tmdb,
        dependencies: [
            Dependency.Internal.requestService,
            Dependency.Internal.utilities,
            Dependency.External.swiftDependencies,
        ],
    )
    static let requestService = target(
        name: TargetNames.requestService,
        dependencies: [
            Dependency.Internal.utilities,
            Dependency.External.swiftDependencies,
            Dependency.External.swiftDependenciesMacros
        ],
    )
    static let utilities = target(
        name: TargetNames.utilities,
        resources: [.resources],
    )
}

//MARK: - Test Targets

extension Target {
    static let tmdbTests = testTarget(
        name: TargetNames.tmdbTests,
        dependencies: [
            "TMDB",
        ],
        resources: [
            .process("JSON"),
        ],
    )
}

extension Target.Dependency {
    enum Internal {
        static let utilities = Target.Dependency.target(name: TargetNames.utilities)
        static let requestService = Target.Dependency.target(name: TargetNames.requestService)
    }

    // External Dependencies
    enum External {
        static let swiftDependencies = Target.Dependency.product(
            name: "Dependencies",
            package: "swift-dependencies"
        )
        static let swiftDependenciesMacros = Target.Dependency.product(
            name: "DependenciesMacros",
            package: "swift-dependencies"
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
