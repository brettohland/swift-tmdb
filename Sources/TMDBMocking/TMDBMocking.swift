import Foundation
import TMDB

/// Provides access to TMDB mock JSON data bundled in the `TMDBMocking` target.
///
/// Mock data is now automatically discovered at runtime — no registration is needed.
public enum TMDBMockData {
    /// Previously required to connect mock data to the TMDB framework.
    ///
    /// This method is now a no-op. Mock data is automatically discovered
    /// via the TMDBMocking resource bundle. You can safely remove calls
    /// to `TMDBMockData.register()` and `import TMDBMocking` from your tests.
    @available(*, deprecated, message: "No longer needed. Mock data is discovered automatically.")
    public static func register() {
        // No-op: mock data is now resolved automatically by MockRouteResolver
        // via runtime bundle discovery.
    }
}
