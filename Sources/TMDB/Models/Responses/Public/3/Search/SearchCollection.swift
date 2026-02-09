import Foundation

public extension TMDB {
    struct SearchCollection: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        public let overview: String
        public let posterPath: String?
        public let backdropPath: String?
    }
}
