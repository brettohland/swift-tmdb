import Foundation

public extension TMDB {
    /// Represents a list of genres from genre list endpoints
    struct GenreList: Codable, Sendable {
        public let genres: [Genre]
    }
}
