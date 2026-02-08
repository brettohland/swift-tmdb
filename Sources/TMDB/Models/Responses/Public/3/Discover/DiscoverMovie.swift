import Foundation

public extension TMDB.Discover {
    struct DiscoverMovie: Codable, Discoverable {
        // MARK: Common

        @NilBoolean
        public var isAdult: Bool
        public let backdropPath: String?
        public let genreIDs: [Int]
        public let id: Int
        @LanguageCode
        public var originalLanguage: Locale.Language
        public let overview: String?
        public let popularity: Double?
        public let posterPath: String?
        @NilBoolean
        public var isVideo: Bool
        public let voteAverage: Double?
        public let voteCount: Int?

        // MARK: Movie Specific

        public let originalTitle: String?
        public let title: String?
        @ISO8601YMD
        public var releaseDate: Date?

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
