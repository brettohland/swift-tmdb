import Foundation

public extension TMDB {
    struct Collection: Codable, Sendable, Identifiable {
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: String?
        public let backdropPath: String?
        public let parts: [Discover.DiscoverMovie]
    }
}
