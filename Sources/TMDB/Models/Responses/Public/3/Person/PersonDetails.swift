import Foundation

public extension TMDB {
    struct Person: Sendable {
        @NilBoolean
        public var isAdult: Bool
        public let alsoKnownAs: [String]
        public let biography: String
        @ISO8601YMD
        public var birthday: Date?
        @ISO8601YMD
        public var deathday: Date?
        public let gender: Gender
        @EmptyStringNullable
        public var homepage: URL?
        public let id: Int
        public let imdbID: String?
        public let knownForDepartment: String
        public let name: String
        public let placeOfBirth: String?
        public let popularity: Double
        public let profilePath: URL?

        public init(
            isAdult: Bool,
            alsoKnownAs: [String],
            biography: String,
            birthday: Date?,
            deathday: Date?,
            gender: Gender,
            homepage: URL?,
            id: Int,
            imdbID: String?,
            knownForDepartment: String,
            name: String,
            placeOfBirth: String?,
            popularity: Double,
            profilePath: URL?,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.alsoKnownAs = alsoKnownAs
            self.biography = biography
            _birthday = ISO8601YMD(wrappedValue: birthday)
            _deathday = ISO8601YMD(wrappedValue: deathday)
            self.gender = gender
            _homepage = EmptyStringNullable(wrappedValue: homepage)
            self.id = id
            self.imdbID = imdbID
            self.knownForDepartment = knownForDepartment
            self.name = name
            self.placeOfBirth = placeOfBirth
            self.popularity = popularity
            self.profilePath = profilePath
        }
    }
}

// MARK: - Nested Types

public extension TMDB.Person {
    enum Gender: Int, Sendable {
        case unspecified = 0
        case female = 1
        case male = 2
        case nonBinary = 3
    }
}

extension TMDB.Person.Gender: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        self = Self(rawValue: value) ?? .unspecified
    }
}

// MARK: - Codable

extension TMDB.Person: Codable {
    enum CodingKeys: String, CodingKey {
        case isAdult = "adult"
        case alsoKnownAs
        case biography
        case birthday
        case deathday
        case gender
        case homepage
        case id
        case imdbID = "imdbId"
        case knownForDepartment
        case name
        case placeOfBirth
        case popularity
        case profilePath
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _isAdult = try container.decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
        alsoKnownAs = try container.decodeIfPresent([String].self, forKey: .alsoKnownAs) ?? []
        biography = try container.decodeIfPresent(String.self, forKey: .biography) ?? ""
        gender = try container.decodeIfPresent(TMDB.Person.Gender.self, forKey: .gender) ?? .unspecified

        if let birthdayString = try container.decodeIfPresent(String.self, forKey: .birthday) {
            _birthday = ISO8601YMD(wrappedValue: try? Date(birthdayString, strategy: .iso8601.year().month().day()))
        } else {
            _birthday = ISO8601YMD(wrappedValue: nil)
        }

        if let deathdayString = try container.decodeIfPresent(String.self, forKey: .deathday) {
            _deathday = ISO8601YMD(wrappedValue: try? Date(deathdayString, strategy: .iso8601.year().month().day()))
        } else {
            _deathday = ISO8601YMD(wrappedValue: nil)
        }

        _homepage = try container
            .decodeIfPresent(EmptyStringNullable.self, forKey: .homepage) ?? EmptyStringNullable(wrappedValue: nil)
        id = try container.decode(Int.self, forKey: .id)
        imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID)
        knownForDepartment = try container.decodeIfPresent(String.self, forKey: .knownForDepartment) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        profilePath = try container.decodeIfPresent(URL.self, forKey: .profilePath)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_isAdult, forKey: .isAdult)
        try container.encode(alsoKnownAs, forKey: .alsoKnownAs)
        try container.encode(biography, forKey: .biography)
        try container.encode(gender, forKey: .gender)
        try container.encode(_birthday, forKey: .birthday)
        try container.encode(_deathday, forKey: .deathday)
        try container.encode(_homepage, forKey: .homepage)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(imdbID, forKey: .imdbID)
        try container.encode(knownForDepartment, forKey: .knownForDepartment)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(placeOfBirth, forKey: .placeOfBirth)
        try container.encode(popularity, forKey: .popularity)
        try container.encodeIfPresent(profilePath, forKey: .profilePath)
    }
}
