import Foundation

public extension TMDB {
    struct SearchPerson: Codable, Sendable, Discoverable {
        public let id: Int
        public let name: String
        @NilBoolean
        public var isAdult: Bool
        public let gender: Int?
        public let knownForDepartment: String?
        public let popularity: Double?
        public let profilePath: URL?
        public let knownFor: [MultiSearchResult]

        public init(
            id: Int,
            name: String,
            isAdult: Bool,
            gender: Int?,
            knownForDepartment: String?,
            popularity: Double?,
            profilePath: URL?,
            knownFor: [MultiSearchResult],
        ) {
            self.id = id
            self.name = name
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.gender = gender
            self.knownForDepartment = knownForDepartment
            self.popularity = popularity
            self.profilePath = profilePath
            self.knownFor = knownFor
        }

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case isAdult = "adult"
            case gender
            case knownForDepartment
            case popularity
            case profilePath
            case knownFor
        }
    }
}
