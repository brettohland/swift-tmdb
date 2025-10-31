import Foundation

public extension TMDBInternal.Discover {
    typealias MovieResponse = Response<DiscoverMovie>
    typealias TVResponse = Response<DiscoverTV>

    struct Response<Title: Codable>: Decodable {
        @NilInteger
        var page: Int
        @NilInteger
        var totalResults: Int
        @NilInteger
        var totalPages: Int
        @NilCodableArray<Title>
        var results: [Title]
    }

    struct DiscoverTV: Codable {
        // MARK: Common

        let backdropPath: URL?
        @NilCodableArray<Int>
        var genreIds: [Int]
        var id: Int
        @ISO639LocaleString
        var originalLanguage: Locale
        let overview: String?
        let popularity: Double?
        let posterPath: String?
        let voteAverage: Double?
        let voteCount: Int?

        // MARK: TV Specific

        let name: String?
        let originalName: String?
        @NilCodableArray
        var originCountry: [Country]
        @ISO8601YMD
        var firstAirDate: Date?
    }

    struct DiscoverMovie: Codable {
        // MARK: Common

        @NilBoolean
        var adult: Bool
        let backdropPath: String?
        @NilCodableArray<Int>
        var genreIds: [Int]
        var id: Int
        @ISO639LocaleString
        var originalLanguage: Locale
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
