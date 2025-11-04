import Dependencies
import Foundation
import RequestService
import SharedModels

public extension TMDB.Client {
    enum Discover {}
}

// MARK: - Discover Movies

public extension TMDB.Client.Discover {
    static func movies(filters: TMDBDiscoverMovieFilter...) async throws -> TMDBInternal.Discover.MovieResponse {
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
    static func tv(filters: TMDBDiscoverTVFilter...) async throws -> TMDBInternal.Discover.TVResponse {
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
