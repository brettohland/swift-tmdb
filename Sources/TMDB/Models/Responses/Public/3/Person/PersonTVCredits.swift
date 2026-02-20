import Foundation

public extension TMDB {
    struct PersonTVCredits: Codable, Identifiable, Sendable {
        public let id: Int
        public let cast: [PersonTVCastCredit]
        public let crew: [PersonTVCrewCredit]

        public init(id: Int, cast: [PersonTVCastCredit], crew: [PersonTVCrewCredit]) {
            self.id = id
            self.cast = cast
            self.crew = crew
        }
    }

    struct PersonTVCastCredit: Sendable {
        public let id: Int
        public let name: String
        public let originalName: String
        public let character: String
        public let creditID: String
        public let episodeCount: Int
        public let firstAirDate: Date?
        public let overview: String
        public let posterPath: URL?
        public let backdropPath: URL?
        public let popularity: Double
        public let voteAverage: Double
        public let voteCount: Int
        public let genreIDs: [Int]
        public let originalLanguage: String
        public let originCountry: [String]
        @NilBoolean
        public var isAdult: Bool

        public init(
            id: Int,
            name: String,
            originalName: String,
            character: String,
            creditID: String,
            episodeCount: Int,
            firstAirDate: Date?,
            overview: String,
            posterPath: URL?,
            backdropPath: URL?,
            popularity: Double,
            voteAverage: Double,
            voteCount: Int,
            genreIDs: [Int],
            originalLanguage: String,
            originCountry: [String],
            isAdult: Bool,
        ) {
            self.id = id
            self.name = name
            self.originalName = originalName
            self.character = character
            self.creditID = creditID
            self.episodeCount = episodeCount
            self.firstAirDate = firstAirDate
            self.overview = overview
            self.posterPath = posterPath
            self.backdropPath = backdropPath
            self.popularity = popularity
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.genreIDs = genreIDs
            self.originalLanguage = originalLanguage
            self.originCountry = originCountry
            _isAdult = NilBoolean(wrappedValue: isAdult)
        }
    }

    struct PersonTVCrewCredit: Sendable {
        public let id: Int
        public let name: String
        public let originalName: String
        public let department: String
        public let job: String
        public let creditID: String
        public let episodeCount: Int
        public let firstAirDate: Date?
        public let overview: String
        public let posterPath: URL?
        public let backdropPath: URL?
        public let popularity: Double
        public let voteAverage: Double
        public let voteCount: Int
        public let genreIDs: [Int]
        public let originalLanguage: String
        public let originCountry: [String]
        @NilBoolean
        public var isAdult: Bool

        public init(
            id: Int,
            name: String,
            originalName: String,
            department: String,
            job: String,
            creditID: String,
            episodeCount: Int,
            firstAirDate: Date?,
            overview: String,
            posterPath: URL?,
            backdropPath: URL?,
            popularity: Double,
            voteAverage: Double,
            voteCount: Int,
            genreIDs: [Int],
            originalLanguage: String,
            originCountry: [String],
            isAdult: Bool,
        ) {
            self.id = id
            self.name = name
            self.originalName = originalName
            self.department = department
            self.job = job
            self.creditID = creditID
            self.episodeCount = episodeCount
            self.firstAirDate = firstAirDate
            self.overview = overview
            self.posterPath = posterPath
            self.backdropPath = backdropPath
            self.popularity = popularity
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.genreIDs = genreIDs
            self.originalLanguage = originalLanguage
            self.originCountry = originCountry
            _isAdult = NilBoolean(wrappedValue: isAdult)
        }
    }
}

// MARK: - Codable

extension TMDB.PersonTVCastCredit: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName
        case character
        case creditID = "creditId"
        case episodeCount
        case firstAirDate
        case overview
        case posterPath
        case backdropPath
        case popularity
        case voteAverage
        case voteCount
        case genreIDs = "genreIds"
        case originalLanguage
        case originCountry
        case isAdult = "adult"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        originalName = try container.decodeIfPresent(String.self, forKey: .originalName) ?? ""
        character = try container.decodeIfPresent(String.self, forKey: .character) ?? ""
        creditID = try container.decodeIfPresent(String.self, forKey: .creditID) ?? ""
        episodeCount = try container.decodeIfPresent(Int.self, forKey: .episodeCount) ?? 0

        if let dateString = try container.decodeIfPresent(String.self, forKey: .firstAirDate) {
            firstAirDate = try? Date(dateString, strategy: .iso8601.year().month().day())
        } else {
            firstAirDate = nil
        }

        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        genreIDs = try container.decodeIfPresent([Int].self, forKey: .genreIDs) ?? []
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
        originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry) ?? []
        _isAdult = try container.decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(originalName, forKey: .originalName)
        try container.encode(character, forKey: .character)
        try container.encode(creditID, forKey: .creditID)
        try container.encode(episodeCount, forKey: .episodeCount)
        if let firstAirDate {
            try container.encode(firstAirDate.formatted(.iso8601.year().month().day()), forKey: .firstAirDate)
        }
        try container.encode(overview, forKey: .overview)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(genreIDs, forKey: .genreIDs)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(originCountry, forKey: .originCountry)
        try container.encode(_isAdult, forKey: .isAdult)
    }
}

extension TMDB.PersonTVCrewCredit: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originalName
        case department
        case job
        case creditID = "creditId"
        case episodeCount
        case firstAirDate
        case overview
        case posterPath
        case backdropPath
        case popularity
        case voteAverage
        case voteCount
        case genreIDs = "genreIds"
        case originalLanguage
        case originCountry
        case isAdult = "adult"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        originalName = try container.decodeIfPresent(String.self, forKey: .originalName) ?? ""
        department = try container.decodeIfPresent(String.self, forKey: .department) ?? ""
        job = try container.decodeIfPresent(String.self, forKey: .job) ?? ""
        creditID = try container.decodeIfPresent(String.self, forKey: .creditID) ?? ""
        episodeCount = try container.decodeIfPresent(Int.self, forKey: .episodeCount) ?? 0

        if let dateString = try container.decodeIfPresent(String.self, forKey: .firstAirDate) {
            firstAirDate = try? Date(dateString, strategy: .iso8601.year().month().day())
        } else {
            firstAirDate = nil
        }

        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        genreIDs = try container.decodeIfPresent([Int].self, forKey: .genreIDs) ?? []
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
        originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry) ?? []
        _isAdult = try container.decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(originalName, forKey: .originalName)
        try container.encode(department, forKey: .department)
        try container.encode(job, forKey: .job)
        try container.encode(creditID, forKey: .creditID)
        try container.encode(episodeCount, forKey: .episodeCount)
        if let firstAirDate {
            try container.encode(firstAirDate.formatted(.iso8601.year().month().day()), forKey: .firstAirDate)
        }
        try container.encode(overview, forKey: .overview)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(genreIDs, forKey: .genreIDs)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(originCountry, forKey: .originCountry)
        try container.encode(_isAdult, forKey: .isAdult)
    }
}
