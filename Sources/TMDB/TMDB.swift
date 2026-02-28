import Foundation
internal import Dependencies

/// The top level namespace for the `swift-tmdb` package
///
/// You must call ``TMDB/initialize(configuration:)`` or ``TMDB/initialize(apiKey:urlSessionConfiguration:)`` before
/// making any calls to the TMDB API.
/// This is because all requests to TMDB require an API key.
@MainActor
public enum TMDB {
    /// The cached image configuration, auto-fetched during ``initialize(configuration:)`` or
    /// ``initialize(apiKey:urlSessionConfiguration:)``.
    ///
    /// Use this to inspect available image sizes (e.g., ``ImageConfiguration/posterSizes``)
    /// or to verify that initialization has completed. Returns `nil` before initialization.
    public internal(set) nonisolated(unsafe) static var imageConfiguration: ImageConfiguration?

    /// The cached list of change keys, auto-fetched during initialization.
    public internal(set) nonisolated(unsafe) static var changeKeys: [Configuration.ChangeKey] = []

    /// Initializes the `swift-tmdb` module with a given configuration value
    /// - Parameter configuration: Allows for customization over various aspects of the framework
    /// - Throws: ``TMDBInitializationError``
    ///
    /// For configuration options, see:
    ///
    /// - ``TMDB/TMDBConfiguration``
    /// - ``TMDB/initialize(apiKey:urlSessionConfiguration:)``
    public static func initialize(configuration: TMDBConfiguration) async throws(TMDBInitializationError) {
        switch try? await Dependency(\.sdkConfigurationStore).wrappedValue.configuration() {
        case .some:
            // There's already a configuration present, throw an error
            throw TMDBInitializationError.alreadyInitialized
        case .none:
            await Dependency(\.sdkConfigurationStore).wrappedValue.setConfiguration(newConfiguration: configuration)
        }

        do {
            let configResponse = try await TMDB.configurationDetails()
            TMDB.imageConfiguration = configResponse.images
            TMDB.changeKeys = configResponse.changeKeys
        } catch {
            throw .configurationFetchFailed(error)
        }
    }

    /// Initialize the `swift-tmdb` module with individual configuration parameters.
    /// - Parameters:
    ///   - apiKey: `String` value from the TMDB website which will be used to authenticate against the TMDB API
    ///   - urlSessionConfiguration: An optional URLSessionConfiguration object to use during requests.
    /// - Throws: ``TMDBInitializationError``
    ///
    /// If no `urlSessionConfiguration` property is included, the framework will use the `.default` static property.
    public static func initialize(
        apiKey: String,
        urlSessionConfiguration: URLSessionConfiguration = .default,
    ) async throws(TMDBInitializationError) {
        let configuration = TMDBConfiguration(apiKey: apiKey)
        try await initialize(configuration: configuration)
    }

    /// Used to check initialization status of the TMDB framework.
    /// - Throws: ``TMDBInitializationError/notYetInitialized`` when not initialized.
    public static func checkIsInitialized() async throws(TMDBInitializationError) {
        do {
            _ = try await Dependency(\.sdkConfigurationStore).wrappedValue.configuration()
        } catch {
            throw TMDBInitializationError.notYetInitialized
        }
    }
}
