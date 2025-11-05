import Foundation
import Mocks
import RegexBuilder
import SharedModels

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
        if url.relativePath.contains(TMDBInternal.V3Endpoints.Configuration.details.pattern) {
            return try TMDBInternal.Configuration.Response.mockData()
        }

        if url.relativePath.contains(TMDBInternal.V3Endpoints.Configuration.countries.pattern) {
            return try TMDBInternal.Configuration.CountriesResponse.mockData()
        }

        if url.relativePath.contains(TMDBInternal.V3Endpoints.Movies.details(id: 0).pattern) {
            return try TMDBInternal.Movie.Details.mockData()
        }

        if url.relativePath.contains(TMDBInternal.V3Endpoints.Movies.alternativeTitles(id: 0).pattern) {
            return try TMDBInternal.Movie.AlternativeTitle.mockData()
        }

        if url.relativePath.contains(TMDBInternal.V3Endpoints.Discover.movie(filters: []).pattern) {
            let movie = try TMDBInternal.Discover.DiscoverMovie.mock()
            let response = TMDBInternal.Discover.PaginatedResponse<TMDBInternal.Discover.DiscoverMovie>(
                page: 1,
                totalResults: 1,
                totalPages: 1,
                results: [movie],
            )
            return try JSONEncoder().encode(response)
        }

        if url.relativePath.contains(TMDBInternal.V3Endpoints.Discover.tv(filters: []).pattern) {
            let show = try TMDBInternal.Discover.DiscoverTV.mock()
            let response = TMDBInternal.Discover.PaginatedResponse<TMDBInternal.Discover.DiscoverTV>(
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

protocol RegexComparable {
    var pattern: Regex<Substring> { get }
}

extension TMDBInternal.V3Endpoints.Configuration: RegexComparable {
    var pattern: Regex<Substring> {
        switch self {
        case .details:
            /^\/3\/configuration$/
        case .countries:
            /^\/3\/configuration\/countries$/
        }
    }
}

extension TMDBInternal.V3Endpoints.Movies: RegexComparable {
    var pattern: Regex<Substring> {
        switch self {
        case .details:
            /^\/3\/movie\/\d+$/
        case .alternativeTitles:
            /^\/3\/movie\/\d+\/alternative_titles$/
        }
    }
}

extension TMDBInternal.V3Endpoints.Discover: RegexComparable {
    var pattern: Regex<Substring> {
        switch self {
        case .movie:
            /^\/3\/discover\/movie$/
        case .tv:
            /^\/3\/discover\/tv$/
        }
    }
}
