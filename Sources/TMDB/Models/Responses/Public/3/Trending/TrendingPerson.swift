import Foundation

public extension TMDB {
    /// Represents a trending person
    struct TrendingPerson: Codable, Sendable, DiscoverType {
        public let id: Int
        public let name: String
        public let profilePath: String?
        public let popularity: Double
        public let knownForDepartment: String?
        public let adult: Bool
    }
}
