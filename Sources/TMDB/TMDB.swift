import Foundation
internal import Dependencies

/// The top level namespace for the TMDBSwifty package
///
/// You must call ``TMDB/initialize(configuration:)`` or ``TMDB/initialize(apiKey:urlSessionConfiguration:)`` before making any calls to the TMDB API.
/// This is because all requests to TMDB require an API key.
@MainActor
public enum TMDB {
    /// Initializes the TMDBSwifty SDK with a given configuration value
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
    }

    /// Initialize the TMDBSwifty SDK with individual configuration parameters.
    /// - Parameters:
    ///   - apiKey: `String` value from the TMDB website which will be used to authenticate against the TMDB API
    ///   - urlSessionConfiguration: An optional ``URLSessionConfiguration`` object to use during requests.
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
