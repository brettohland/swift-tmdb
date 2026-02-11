import Foundation

public extension TMDB.Discover {
    struct DiscoverTV: Codable, Discoverable {
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
        }
    }
}
