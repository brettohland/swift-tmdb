
import Foundation

public extension TMDBInternal {
    struct TitleCollection: Codable, Equatable, Identifiable, Sendable {
        public let id: Int
        public let name: String
        public let posterPath: String
        public let backdropPath: String
    }
}
