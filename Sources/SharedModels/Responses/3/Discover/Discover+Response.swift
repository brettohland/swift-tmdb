import Foundation

public protocol DiscoverType: Codable {}

public extension TMDBInternal.Discover {
    typealias MovieResponse = PaginatedResponse<DiscoverMovie>
    typealias TVResponse = PaginatedResponse<DiscoverTV>

    struct PaginatedResponse<Wrapped: DiscoverType>: Codable {
        @NilInteger
        public var page: Int
        @NilInteger
        public var totalResults: Int
        @NilInteger
        public var totalPages: Int
        @NilCodableArray<Wrapped>
        public var results: [Wrapped]

        public init(
            page: Int,
            totalResults: Int,
            totalPages: Int,
            results: [Wrapped]
        ) {
            _page = NilInteger(wrappedValue: page)
            _totalResults = NilInteger(wrappedValue: totalResults)
            _totalPages = NilInteger(wrappedValue: totalPages)
            _results = NilCodableArray(wrappedValue: results)
        }
    }

    struct DiscoverTV: Codable, DiscoverType {
        // MARK: Common

        let backdropPath: URL?
        @NilCodableArray<Int>
        var genreIds: [Int]
        var id: Int
        @LanguageCode
        var originalLanguage: Locale.Language
        let overview: String?
        let popularity: Double?
        let posterPath: String?
        let voteAverage: Double?
        let voteCount: Int?

        // MARK: TV Specific

        let name: String?
        let originalName: String?
        var originCountry: [Locale.Region]
        @ISO8601YMD
        var firstAirDate: Date?
    }

    struct DiscoverMovie: Codable, DiscoverType {
        // MARK: Common

        @NilBoolean
        var adult: Bool
        let backdropPath: String?
        @NilCodableArray<Int>
        var genreIds: [Int]
        var id: Int
        @LanguageCode
        var originalLanguage: Locale.Language
        let overview: String?
        let popularity: Double?
        let posterPath: String?
        @NilBoolean
        var video: Bool
        let voteAverage: Double?
        let voteCount: Int?

        // MARK: Movie Specific

        let originalTitle: String?
        let title: String?
        @ISO8601YMD
        var releaseDate: Date?
    }
}
