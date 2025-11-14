import Foundation

public extension TMDB.Discover {
    struct DiscoverMovie: Codable, DiscoverType {
        // MARK: Common

        @NilBoolean
        public var adult: Bool
        public let backdropPath: String?
        public var genreIds: [Int]
        public var id: Int
        @LanguageCode
        public var originalLanguage: Locale.Language
        public let overview: String?
        public let popularity: Double?
        public let posterPath: String?
        @NilBoolean
        public var video: Bool
        public let voteAverage: Double?
        public let voteCount: Int?

        // MARK: Movie Specific

        public let originalTitle: String?
        public let title: String?
        @ISO8601YMD
        public var releaseDate: Date?
    }
}
