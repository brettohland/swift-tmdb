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

        public init(
            id: Int,
            name: String,
            profilePath: URL?,
            popularity: Double,
            knownForDepartment: String?,
            isAdult: Bool,
        ) {
            self.id = id
            self.name = name
            self.profilePath = profilePath
            self.popularity = popularity
            self.knownForDepartment = knownForDepartment
            _isAdult = NilBoolean(wrappedValue: isAdult)
        }

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
