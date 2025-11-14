import Foundation

public extension TMDB.Discover {
    struct DiscoverTV: Codable, DiscoverType {
        // MARK: Common

        public let backdropPath: URL?
        public var genreIds: [Int]
        public var id: Int
        @LanguageCode
        public var originalLanguage: Locale.Language
        public let overview: String?
        public let popularity: Double?
        public let posterPath: String?
        public let voteAverage: Double?
        public let voteCount: Int?

        // MARK: TV Specific

        public let name: String?
        public let originalName: String?
        public var originCountry: [Locale.Region]
        @ISO8601YMD
        public var firstAirDate: Date?
    }
}
