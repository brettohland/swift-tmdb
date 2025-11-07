internal import Dependencies
internal import DependenciesMacros
import Foundation

extension TMDB {
    @DependencyClient
    struct SDKConfigurationProvider: Sendable {
        static let liveStore = LiveConfigurationStore()
        var configuration: @Sendable () async throws -> TMDBConfiguration
        var setConfiguration: @Sendable (_ newConfiguration: TMDBConfiguration) async -> Void
    }
}

extension DependencyValues {
    var sdkConfigurationStore: TMDB.SDKConfigurationProvider {
        get { self[TMDB.SDKConfigurationProvider.self] }
        set { self[TMDB.SDKConfigurationProvider.self] = newValue }
    }
}

extension TMDB.SDKConfigurationProvider: DependencyKey {
    static var liveValue: Self {
        TMDB.SDKConfigurationProvider(
            configuration: { () throws(TMDBInitializationError) in
                guard let configuration = await TMDB.SDKConfigurationProvider.liveStore.configuration else {
                    throw .notYetInitialized
                }
                return configuration
            },
            setConfiguration: { newConfiguration in
                Task {
                    await TMDB.SDKConfigurationProvider.liveStore.setConfiguration(newConfiguration)
                }
            },
        )
    }
}

extension TMDB.SDKConfigurationProvider: TestDependencyKey {
    static var testValue: TMDB.SDKConfigurationProvider {
        TMDB.SDKConfigurationProvider(
            configuration: {
                return .init(apiKey: "", urlSessionConfiguration: .default)
            },
            setConfiguration: { _ in
                runtimeWarning("Attempting to set the API key during testing, nothing will happen")
            },
        )
    }

    static var previewValue: TMDB.SDKConfigurationProvider {
        TMDB.SDKConfigurationProvider(
            configuration: {
                // Returning a random, non-nil response so that tests will work correctly
                return .init(apiKey: "", urlSessionConfiguration: .default)
            },
            setConfiguration: { _ in
                // No-op since it really doesn't matter what we do in tests here
            },
        )
    }
}

extension TMDB {
    final actor LiveConfigurationStore {
        var configuration: TMDBConfiguration?

        init() {}

        func setConfiguration(_ newConfiguration: TMDBConfiguration) async {
            configuration = newConfiguration
        }
    }
}
