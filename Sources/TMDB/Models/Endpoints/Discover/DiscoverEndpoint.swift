import Foundation

extension TMDB.V3Endpoints {
    enum Discover {
        case movie(filters: [TMDB.Discover.MovieFilter])
        case tv(filters: [TMDB.Discover.TVFilter])
    }
}

extension TMDB.V3Endpoints.Discover: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
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

// MARK: - Discover Movies

public extension TMDB {
    /// `/3/discover/movie`
    /// `
    /// - Parameter filters: A parameter list of zero or more filters to include in the search
    /// - Returns: ``TMDB/Discover/MovieResponse``
    static func discoverMovies(filters: TMDB.Discover.MovieFilter...) async throws -> TMDB.Discover.MovieResponse {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.MovieResponse>(
            endpoint: TMDB.V3Endpoints.Discover.movie(filters: filters),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    /// `/3/discover/movie`
    /// - Returns: A paginated response value
    static func discoverMovies() async throws -> TMDB.Discover.MovieResponse {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.MovieResponse>(
            endpoint: TMDB.V3Endpoints.Discover.movie(filters: []),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }
}

// MARK: - Discover TV

public extension TMDB {
    /// `/3/discover/tv`
    ///
    /// - Parameter filters: A parameter list of zero or more filters to include in the search
    /// - Returns: A paginated response value
    static func discoverTV(filters: TMDB.Discover.TVFilter...) async throws -> TMDB.Discover.TVResponse {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.TVResponse>(
            endpoint: TMDB.V3Endpoints.Discover.tv(filters: filters),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    /// `/3/discover/tv`
    ///
    /// - Returns: A paginated response value
    static func discoverTV() async throws -> TMDB.Discover.TVResponse {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.TVResponse>(
            endpoint: TMDB.V3Endpoints.Discover.tv(filters: []),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }
}
