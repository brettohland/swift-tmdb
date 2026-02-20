import Dependencies
import Foundation
@testable import TMDB

func withLiveTMDB<T>(
    _ operation: () async throws -> T,
) async throws -> T {
    guard let apiKey = TMDBCredential.apiKey else {
        fatalError("TMDB_API_KEY environment variable is not set")
    }

    return try await withDependencies {
        $0.httpClient = .liveValue
        $0.sdkConfigurationStore = TMDB.SDKConfigurationProvider(
            configuration: {
                TMDBConfiguration(
                    apiKey: apiKey,
                    urlSessionConfiguration: .default,
                    minimumLoggingLevel: .debug,
                )
            },
            setConfiguration: { _ in },
        )
    } operation: {
        try await operation()
    }
}
