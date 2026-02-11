import Foundation

public extension TMDB {
    struct TitleCollection: Codable, Equatable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let posterPath: URL
        public let backdropPath: URL
    }
}
