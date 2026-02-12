import Foundation
import TMDB

/// Provides access to TMDB mock JSON data bundled in the `TMDBMocking` target.
///
/// Call ``register()`` before running tests or using SwiftUI previews
/// to connect mock data to the TMDB framework.
public enum TMDBMockData {
    /// Registers the mock data handler with the TMDB framework.
    ///
    /// This must be called before any TMDB API calls are made in test
    /// or preview contexts. Typically called in test struct `init()`.
    public static func register() {
        TMDB.mockDataHandler = { request in
            try PathMatchingService.dataFromURLRequest(request)
        }
    }
}
