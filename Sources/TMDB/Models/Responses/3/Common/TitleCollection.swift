
import Foundation

public extension TMDB {
    struct TitleCollection: Codable, Equatable, Identifiable {
        public let id: Int
        public let name: String
        public let posterPath: String
        public let backdropPath: String
    }
}
