import Foundation
import RequestService
import SharedModels

extension TMDBInternal.V3Endpoints {
    enum Discover {
        case movie(filters: [TMDBInternal.Discover.MovieFilter])
        case tv(filters: [TMDBInternal.Discover.TVFilter])
    }
}

extension TMDBInternal.V3Endpoints.Discover: EndpointFactory {
    public func makeURL(baseURL: URL) -> URL {
        // /3/discover
        var paths = ["3", "discover"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .movie(let filters):
            // /3/discover/movie
            paths.append("movie")
            queryItems = filters.map(\.queryItem)
        case .tv(let filters):
            // /3/discover/tv
            paths.append("tv")
            queryItems = filters.map(\.queryItem)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

public extension TMDB.Client {
    enum Discover {}
}

// MARK: - Discover Movies

public extension TMDB.Client.Discover {
    static func movies(filters: TMDBInternal.Discover.MovieFilter...) async throws -> TMDBInternal.Discover.MovieResponse {
        let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Discover.MovieResponse>(
            endpoint: TMDBInternal.V3Endpoints.Discover.movie(filters: filters),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    static func movies() async throws -> TMDBInternal.Discover.MovieResponse {
        let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Discover.MovieResponse>(
            endpoint: TMDBInternal.V3Endpoints.Discover.movie(filters: []),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }
}

// MARK: - Discover TV

public extension TMDB.Client.Discover {
    static func tv(filters: TMDBInternal.Discover.TVFilter...) async throws -> TMDBInternal.Discover.TVResponse {
        let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Discover.TVResponse>(
            endpoint: TMDBInternal.V3Endpoints.Discover.tv(filters: filters),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    static func tv() async throws -> TMDBInternal.Discover.TVResponse {
        let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDBInternal.Discover.TVResponse>(
            endpoint: TMDBInternal.V3Endpoints.Discover.tv(filters: []),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }
}
