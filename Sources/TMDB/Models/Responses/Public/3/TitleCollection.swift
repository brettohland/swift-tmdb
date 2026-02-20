import Foundation

public extension TMDB {
    struct TitleCollection: Codable, Equatable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let posterPath: URL
        public let backdropPath: URL

        public init(id: Int, name: String, posterPath: URL, backdropPath: URL) {
            self.id = id
            self.name = name
            self.posterPath = posterPath
            self.backdropPath = backdropPath
        }
    }
}
