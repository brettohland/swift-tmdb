import Foundation

public extension TMDB {
    struct SearchCollection: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: URL?
        public let backdropPath: URL?

        public init(id: Int, name: String, overview: String, posterPath: URL?, backdropPath: URL?) {
            self.id = id
            self.name = name
            self.overview = overview
            self.posterPath = posterPath
            self.backdropPath = backdropPath
        }
    }
}
