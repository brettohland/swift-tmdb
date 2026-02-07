import Foundation

extension TMDB.V3Endpoints {
    enum Genres {
        case movieList
        case tvList
    }
}

extension TMDB.V3Endpoints.Genres: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "genre"]
        switch self {
        case .movieList:
            // /3/genre/movie/list
            paths += ["movie", "list"]
        case .tvList:
            // /3/genre/tv/list
            paths += ["tv", "list"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

public extension TMDB {
    /// `/3/genre/movie/list`
    /// [API Documentation](https://developer.themoviedb.org/reference/genre-movie-list)
    /// - Returns: Movie genre list
    static func movieGenres() async throws -> TMDB.GenreList {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.GenreList>(
            endpoint: V3Endpoints.Genres.movieList,
            httpMethod: .get
        )
        return try await endpoint.decodedResponse()
    }

    /// `/3/genre/tv/list`
    /// [API Documentation](https://developer.themoviedb.org/reference/genre-tv-list)
    /// - Returns: TV genre list
    static func tvGenres() async throws -> TMDB.GenreList {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.GenreList>(
            endpoint: V3Endpoints.Genres.tvList,
            httpMethod: .get
        )
        return try await endpoint.decodedResponse()
    }
}
