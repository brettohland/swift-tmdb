import Foundation
internal import Dependencies

@MainActor
public final class TMDB {
    /// Initializes the TMDBSwifty SDK with a given configuration value
    /// - Parameter configuration: ``TMDBConfiguration`` used to set up the SDK
    /// - Throws: ``TMDBInitializationError``
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
    ///   - urlSessionConfiguration: Allows the SDK to use a specific `URLSessionConfiguration` for all network
    ///   requests. Note: The SDK will automatically append the API key to all requests.
    /// - Throws: ``TMDBInitializationError``
    public static func initialize(
        apiKey: String,
        urlSessionConfiguration: URLSessionConfiguration = .default,
    ) async throws(TMDBInitializationError) {
        let configuration = TMDBConfiguration(apiKey: apiKey)
        try await initialize(configuration: configuration)
    }

    /// Check that the TMDB SDK has been initialized
    /// - Throws: ``TMDBInitializationError.notYetInitialized``
    public static func checkIsInitialized() async throws(TMDBInitializationError) {
        do {
            _ = try await Dependency(\.sdkConfigurationStore).wrappedValue.configuration()
        } catch {
            throw TMDBInitializationError.notYetInitialized
        }
    }
}
