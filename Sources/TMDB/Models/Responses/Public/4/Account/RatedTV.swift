import Foundation

public extension TMDB.Account {
    struct RatedTV: Codable, Sendable {
        public let backdropPath: URL?
        public let genreIDs: [Int]
        public let id: Int
        @LanguageCode
        public var originalLanguage: Locale.Language
        public let overview: String?
        public let popularity: Double?
        public let posterPath: URL?
        public let voteAverage: Double?
        public let voteCount: Int?
        public let name: String?
        public let originalName: String?
        public let originCountry: [Locale.Region]
        @ISO8601YMD
        public var firstAirDate: Date?
        public let accountRating: TMDB.Account.AccountRating

        public init(
            backdropPath: URL?,
            genreIDs: [Int],
            id: Int,
            originalLanguage: Locale.Language,
            overview: String?,
            popularity: Double?,
            posterPath: URL?,
            voteAverage: Double?,
            voteCount: Int?,
            name: String?,
            originalName: String?,
            originCountry: [Locale.Region],
            firstAirDate: Date?,
            accountRating: TMDB.Account.AccountRating,
        ) {
            self.backdropPath = backdropPath
            self.genreIDs = genreIDs
            self.id = id
            _originalLanguage = LanguageCode(wrappedValue: originalLanguage)
            self.overview = overview
            self.popularity = popularity
            self.posterPath = posterPath
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.name = name
            self.originalName = originalName
            self.originCountry = originCountry
            _firstAirDate = ISO8601YMD(wrappedValue: firstAirDate)
            self.accountRating = accountRating
        }

        enum CodingKeys: String, CodingKey {
            case backdropPath
            case genreIDs = "genreIds"
            case id
            case originalLanguage
            case overview
            case popularity
            case posterPath
            case voteAverage
            case voteCount
            case name
            case originalName
            case originCountry
            case firstAirDate
            case accountRating
        }
    }
}

extension TMDB.Account.RatedTV: Discoverable {}
