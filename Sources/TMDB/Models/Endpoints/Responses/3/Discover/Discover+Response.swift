import Foundation

protocol DiscoverType: Codable, Sendable {}

extension TMDB {
    enum Discover {}
}

extension TMDB.Discover {
    typealias MovieResponse = PaginatedResponse<DiscoverMovie>
    typealias TVResponse = PaginatedResponse<DiscoverTV>

    struct PaginatedResponse<Wrapped: DiscoverType>: Codable, Sendable {
        @NilInteger
        var page: Int
        @NilInteger
        var totalResults: Int
        @NilInteger
        var totalPages: Int
        var results: [Wrapped]
    }

    struct DiscoverTV: Codable, DiscoverType {
        // MARK: Common

        let backdropPath: URL?
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
