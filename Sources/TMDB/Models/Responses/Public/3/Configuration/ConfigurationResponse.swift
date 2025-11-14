import Foundation

public extension TMDB {
    /// Represents the JSON response from the `/3/configuration/details` endpoint
    ///
    /// [Details on TMDB's site](https://developer.themoviedb.org/reference/configuration-details)
    struct ConfigurationResponse: Codable, Sendable {
        public let images: ImageConfiguration?
        public var changeKeys: [TMDB.Configuration.ChangeKey]
    }
}
