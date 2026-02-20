import Foundation

public extension TMDB.GuestSession {
    struct RatedTV: Codable, Sendable {
        // MARK: Common

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

        // MARK: TV Specific

        public let name: String?
        public let originalName: String?
        public let originCountry: [Locale.Region]
        @ISO8601YMD
        public var firstAirDate: Date?

        // MARK: Rating

        public let rating: Double

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
            rating: Double,
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
            self.rating = rating
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
            case rating
        }
    }
}

extension TMDB.GuestSession.RatedTV: Discoverable {}
