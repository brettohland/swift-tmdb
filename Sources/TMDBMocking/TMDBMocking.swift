import Foundation
import TMDB

/// Provides access to TMDB mock JSON data bundled in the `TMDBMocking` target.
///
/// Mock bundle discovery is automatic when linking the `TMDB` product.
/// If auto-discovery fails, call ``register()`` manually at app launch.
public enum TMDBMockData {
    /// Manually registers the mock resource bundle with the TMDB framework.
    ///
    /// This is a fallback for environments where automatic bundle discovery
    /// does not work. In most cases, you do not need to call this.
    public static func register() {
        MockUtilities.mockResourceBundle = Bundle.module
    }
}
