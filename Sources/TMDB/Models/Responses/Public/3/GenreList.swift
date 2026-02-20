import Foundation

public extension TMDB {
    /// Represents a list of genres from genre list endpoints
    struct GenreList: Codable, Sendable {
        public let genres: [Genre]

        public init(genres: [Genre]) {
            self.genres = genres
        }
    }
}
