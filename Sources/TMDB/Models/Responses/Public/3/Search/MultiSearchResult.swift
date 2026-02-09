import Foundation

public extension TMDB {
    /// Represents a multi-search result that can be a movie, TV show, or person
    struct MultiSearchResult: Sendable, Discoverable {
        public let id: Int
        public let mediaType: String
        public let title: String?
        public let name: String?
        public let originalTitle: String?
        public let originalName: String?
        public let overview: String?
        public let posterPath: String?
        public let backdropPath: String?
        public let profilePath: String?
        public let popularity: Double?
        public let voteAverage: Double?
        public let voteCount: Int?
        public let releaseDate: Date?
        public let firstAirDate: Date?
        @NilBoolean
        public var isAdult: Bool
        public let genreIDs: [Int]?
        public let knownForDepartment: String?
        public let gender: Int?
        public let knownFor: [MultiSearchResult]?
        public let originCountry: [String]?
    }
}

extension TMDB.MultiSearchResult: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType
        case title
        case name
        case originalTitle
        case originalName
        case overview
        case posterPath
        case backdropPath
        case profilePath
        case popularity
        case voteAverage
        case voteCount
        case releaseDate
        case firstAirDate
        case isAdult = "adult"
        case genreIDs = "genreIds"
        case knownForDepartment
        case gender
        case knownFor
        case originCountry
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        mediaType = try container.decode(String.self, forKey: .mediaType)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        originalName = try container.decodeIfPresent(String.self, forKey: .originalName)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)

        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = try? Date(releaseDateString, strategy: .iso8601.year().month().day())
        } else {
            releaseDate = nil
        }

        if let firstAirDateString = try container.decodeIfPresent(String.self, forKey: .firstAirDate) {
            firstAirDate = try? Date(firstAirDateString, strategy: .iso8601.year().month().day())
        } else {
            firstAirDate = nil
        }

        _isAdult = try container.decodeIfPresent(NilBoolean.self, forKey: .isAdult) ?? NilBoolean(wrappedValue: false)
        genreIDs = try container.decodeIfPresent([Int].self, forKey: .genreIDs)
        knownForDepartment = try container.decodeIfPresent(String.self, forKey: .knownForDepartment)
        gender = try container.decodeIfPresent(Int.self, forKey: .gender)
        knownFor = try container.decodeIfPresent([TMDB.MultiSearchResult].self, forKey: .knownFor)
        originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(mediaType, forKey: .mediaType)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
        try container.encodeIfPresent(originalName, forKey: .originalName)
        try container.encodeIfPresent(overview, forKey: .overview)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encodeIfPresent(profilePath, forKey: .profilePath)
        try container.encodeIfPresent(popularity, forKey: .popularity)
        try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
        try container.encodeIfPresent(voteCount, forKey: .voteCount)

        if let releaseDate {
            try container.encode(releaseDate.formatted(.iso8601.year().month().day()), forKey: .releaseDate)
        }

        if let firstAirDate {
            try container.encode(firstAirDate.formatted(.iso8601.year().month().day()), forKey: .firstAirDate)
        }

        try container.encode(_isAdult, forKey: .isAdult)
        try container.encodeIfPresent(genreIDs, forKey: .genreIDs)
        try container.encodeIfPresent(knownForDepartment, forKey: .knownForDepartment)
        try container.encodeIfPresent(gender, forKey: .gender)
        try container.encodeIfPresent(knownFor, forKey: .knownFor)
        try container.encodeIfPresent(originCountry, forKey: .originCountry)
    }
}
