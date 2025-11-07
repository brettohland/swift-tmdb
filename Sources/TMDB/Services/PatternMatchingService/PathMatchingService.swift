import Foundation
import RegexBuilder

enum PathMatchingService {
    enum MatchingError: Error {
        case missingURL
        case invalidV3Path([String])
        case unsupportedAPIVersion
    }

    static func dataFromURLRequest(_ request: URLRequest) throws -> Data {
        guard let url = request.url else {
            throw MatchingError.missingURL
        }
        switch url.pathComponents[1] {
        case "3":
            return try handleV3Path(url)
        case "4":
            return try handleV4Paths(url)
        default:
            throw MatchingError.unsupportedAPIVersion
        }
    }

    static func handleV3Path(_ url: URL) throws -> Data {
        if url.relativePath.contains(TMDB.V3Endpoints.Configuration.details.pattern) {
            return try TMDB.Configuration.Response.mockData()
        }

        if url.relativePath.contains(TMDB.V3Endpoints.Configuration.countries.pattern) {
            return try TMDB.Configuration.CountriesResponse.mockData()
        }

        if url.relativePath.contains(TMDB.V3Endpoints.Movies.details(id: 0).pattern) {
            return try TMDB.Movie.mockData()
        }

        if url.relativePath.contains(TMDB.V3Endpoints.Movies.alternativeTitles(id: 0).pattern) {
            return try TMDB.AlternativeTitle.mockData()
        }

        if url.relativePath.contains(TMDB.V3Endpoints.Discover.movie(filters: []).pattern) {
            let movie = try TMDB.Discover.DiscoverMovie.mock()
            let response = TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>(
                page: 1,
                totalResults: 1,
                totalPages: 1,
                results: [movie],
            )
            return try JSONEncoder().encode(response)
        }

        if url.relativePath.contains(TMDB.V3Endpoints.Discover.tv(filters: []).pattern) {
            let show = try TMDB.Discover.DiscoverTV.mock()
            let response = TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>(
                page: 1,
                totalResults: 1,
                totalPages: 1,
                results: [show],
            )
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try encoder.encode(response)
        }

        throw MatchingError.unsupportedAPIVersion
    }

    static func handleV4Paths(_ url: URL) throws -> Data {
        throw MatchingError.unsupportedAPIVersion
    }
}
