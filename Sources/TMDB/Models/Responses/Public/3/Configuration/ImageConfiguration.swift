import Foundation

public extension TMDB {
    /// Supported image configuration details
    struct ImageConfiguration: Codable, Sendable {
        public let baseUrl: URL?
        public let secureBaseUrl: URL?
        public var backdropSizes: [TMDB.Configuration.ImageSize]
        public var logoSizes: [TMDB.Configuration.ImageSize]
        public var posterSizes: [TMDB.Configuration.ImageSize]
        public var profileSizes: [TMDB.Configuration.ImageSize]
        public var stillSizes: [TMDB.Configuration.ImageSize]
    }
}
