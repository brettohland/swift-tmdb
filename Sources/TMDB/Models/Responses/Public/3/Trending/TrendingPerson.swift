import Foundation

public extension TMDB {
    /// Represents a trending person
    struct TrendingPerson: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        public let profilePath: URL?
        public let popularity: Double
        public let knownForDepartment: String?
        @NilBoolean public var isAdult: Bool

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
