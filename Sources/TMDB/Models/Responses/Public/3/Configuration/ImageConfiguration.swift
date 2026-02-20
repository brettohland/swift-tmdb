import Foundation

public extension TMDB {
    /// Supported image configuration details
    struct ImageConfiguration: Codable, Sendable {
        public let baseUrl: URL?
        public let secureBaseUrl: URL?
        public let backdropSizes: [TMDB.Configuration.ImageSize]
        public let logoSizes: [TMDB.Configuration.ImageSize]
        public let posterSizes: [TMDB.Configuration.ImageSize]
        public let profileSizes: [TMDB.Configuration.ImageSize]
        public let stillSizes: [TMDB.Configuration.ImageSize]

        public init(
            baseUrl: URL?,
            secureBaseUrl: URL?,
            backdropSizes: [TMDB.Configuration.ImageSize],
            logoSizes: [TMDB.Configuration.ImageSize],
            posterSizes: [TMDB.Configuration.ImageSize],
            profileSizes: [TMDB.Configuration.ImageSize],
            stillSizes: [TMDB.Configuration.ImageSize],
        ) {
            self.baseUrl = baseUrl
            self.secureBaseUrl = secureBaseUrl
            self.backdropSizes = backdropSizes
            self.logoSizes = logoSizes
            self.posterSizes = posterSizes
            self.profileSizes = profileSizes
            self.stillSizes = stillSizes
        }
    }
}
