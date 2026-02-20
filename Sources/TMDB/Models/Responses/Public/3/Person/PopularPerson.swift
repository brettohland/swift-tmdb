import Foundation

public extension TMDB {
    struct PopularPerson: Sendable {
        public let id: Int
        public let name: String
        public let gender: Person.Gender
        public let knownForDepartment: String
        public let profilePath: URL?
        public let popularity: Double
        @NilBoolean
        public var isAdult: Bool
        public let knownFor: [MultiSearchResult]

        public init(
            id: Int,
            name: String,
            gender: Person.Gender,
            knownForDepartment: String,
            profilePath: URL?,
            popularity: Double,
            isAdult: Bool,
            knownFor: [MultiSearchResult],
        ) {
            self.id = id
            self.name = name
            self.gender = gender
            self.knownForDepartment = knownForDepartment
            self.profilePath = profilePath
            self.popularity = popularity
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.knownFor = knownFor
        }
    }
}

// MARK: - Codable

extension TMDB.PopularPerson: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case knownForDepartment
        case profilePath
        case popularity
        case isAdult = "adult"
        case knownFor
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        gender = try container.decodeIfPresent(TMDB.Person.Gender.self, forKey: .gender) ?? .unspecified
        knownForDepartment = try container.decodeIfPresent(String.self, forKey: .knownForDepartment) ?? ""
        profilePath = try container.decodeIfPresent(URL.self, forKey: .profilePath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        _isAdult = try container.decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
        knownFor = try container.decodeIfPresent([TMDB.MultiSearchResult].self, forKey: .knownFor) ?? []
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(gender, forKey: .gender)
        try container.encode(knownForDepartment, forKey: .knownForDepartment)
        try container.encodeIfPresent(profilePath, forKey: .profilePath)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(_isAdult, forKey: .isAdult)
        try container.encode(knownFor, forKey: .knownFor)
    }
}

extension TMDB.PopularPerson: Identifiable {}
extension TMDB.PopularPerson: Discoverable {}
