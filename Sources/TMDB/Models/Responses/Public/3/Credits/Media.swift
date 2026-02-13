import Foundation

public extension TMDB.Credits {
    struct Media: Codable, Identifiable, Sendable {
        @NilBoolean public var isAdult: Bool
        public let backdropPath: URL
        public let id: Int
        public let name: String
        @LanguageCode
        public var originalLanguage: Locale.Language
        public let originalName: String
        public let overview: String
        public let posterPath: URL
        public let mediaType: String
        public let genreIDs: [Int]
        public let popularity: Double
        @ISO8601YMD
        public var firstAirDate: Date?
        public let voteAverage: Double
        public let voteCount: Int
        public let originCountry: [Locale.Region]
        public let seasons: [Season]

        public init(
            isAdult: Bool,
            backdropPath: URL,
            id: Int,
            name: String,
            originalLanguage: Locale.Language,
            originalName: String,
            overview: String,
            posterPath: URL,
            mediaType: String,
            genreIDs: [Int],
            popularity: Double,
            firstAirDate: Date?,
            voteAverage: Double,
            voteCount: Int,
            originCountry: [Locale.Region],
            seasons: [Season],
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.backdropPath = backdropPath
            self.id = id
            self.name = name
            _originalLanguage = LanguageCode(wrappedValue: originalLanguage)
            self.originalName = originalName
            self.overview = overview
            self.posterPath = posterPath
            self.mediaType = mediaType
            self.genreIDs = genreIDs
            self.popularity = popularity
            _firstAirDate = ISO8601YMD(wrappedValue: firstAirDate)
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.originCountry = originCountry
            self.seasons = seasons
        }

        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case backdropPath
            case id
            case name
            case originalLanguage
            case originalName
            case overview
            case posterPath
            case mediaType
            case genreIDs = "genreIds"
            case popularity
            case firstAirDate
            case voteAverage
            case voteCount
            case originCountry
            case seasons
        }
    }
}
