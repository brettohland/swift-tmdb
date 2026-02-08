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
    }
}
