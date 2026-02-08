import Foundation

public extension TMDB {
    /// Represents a trending person
    struct TrendingPerson: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        public let profilePath: String?
        public let popularity: Double
        public let knownForDepartment: String?
        public let isAdult: Bool

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case profilePath
            case popularity
            case knownForDepartment
            case isAdult = "adult"
        }
    }
}
