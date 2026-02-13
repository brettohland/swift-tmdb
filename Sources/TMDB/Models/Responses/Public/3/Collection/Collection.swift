import Foundation

public extension TMDB {
    struct Collection: Codable, Sendable, Identifiable {
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: URL?
        public let backdropPath: URL?
        public let parts: [Discover.DiscoverMovie]

        public init(
            id: Int,
            name: String,
            overview: String,
            posterPath: URL?,
            backdropPath: URL?,
            parts: [Discover.DiscoverMovie],
        ) {
            self.id = id
            self.name = name
            self.overview = overview
            self.posterPath = posterPath
            self.backdropPath = backdropPath
            self.parts = parts
        }
    }
}
