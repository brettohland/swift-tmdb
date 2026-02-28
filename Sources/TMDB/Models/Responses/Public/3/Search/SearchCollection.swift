import Foundation

public extension TMDB {
    struct SearchCollection: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: String?
        public let backdropPath: String?

        public init(id: Int, name: String, overview: String, posterPath: String?, backdropPath: String?) {
            self.id = id
            self.name = name
            self.overview = overview
            self.posterPath = posterPath
            self.backdropPath = backdropPath
        }
    }
}
