import Foundation

public extension TMDB.Discover {
    struct DiscoverMovie: Codable, Discoverable {
        // MARK: Common

        @NilBoolean
        public var isAdult: Bool
        public let backdropPath: URL?
        public let genreIDs: [Int]
        public let id: Int
        @LanguageCode
        public var originalLanguage: Locale.Language
        public let overview: String?
        public let popularity: Double?
        public let posterPath: URL?
        @NilBoolean
        public var isVideo: Bool
        public let voteAverage: Double?
        public let voteCount: Int?

        // MARK: Movie Specific

        public let originalTitle: String?
        public let title: String?
        @ISO8601YMD
        public var releaseDate: Date?

        public init(
            isAdult: Bool,
            backdropPath: URL?,
            genreIDs: [Int],
            id: Int,
            originalLanguage: Locale.Language,
            overview: String?,
            popularity: Double?,
            posterPath: URL?,
            isVideo: Bool,
            voteAverage: Double?,
            voteCount: Int?,
            originalTitle: String?,
            title: String?,
            releaseDate: Date?,
        ) {
            _isAdult = NilBoolean(wrappedValue: isAdult)
            self.backdropPath = backdropPath
            self.genreIDs = genreIDs
            self.id = id
            _originalLanguage = LanguageCode(wrappedValue: originalLanguage)
            self.overview = overview
            self.popularity = popularity
            self.posterPath = posterPath
            _isVideo = NilBoolean(wrappedValue: isVideo)
            self.voteAverage = voteAverage
            self.voteCount = voteCount
            self.originalTitle = originalTitle
            self.title = title
            _releaseDate = ISO8601YMD(wrappedValue: releaseDate)
        }

        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case backdropPath
            case genreIDs = "genreIds"
            case id
            case originalLanguage
            case overview
            case popularity
            case posterPath
            case isVideo = "video"
            case voteAverage
            case voteCount
            case originalTitle
            case title
            case releaseDate
        }
    }
}
