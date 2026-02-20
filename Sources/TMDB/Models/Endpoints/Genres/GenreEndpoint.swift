import Foundation

extension TMDB.V3Endpoints {
    enum Genres {
        case movieList(language: Locale?)
        case tvList(language: Locale?)
    }
}

extension TMDB.V3Endpoints.Genres: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "genre"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .movieList(let language):
            // /3/genre/movie/list
            paths += ["movie", "list"]
            queryItems.appendIfPresent(.language, value: language)
        case .tvList(let language):
            // /3/genre/tv/list
            paths += ["tv", "list"]
            queryItems.appendIfPresent(.language, value: language)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

public extension TMDB {
    /// `/3/genre/movie/list`
    /// [API Documentation](https://developer.themoviedb.org/reference/genre-movie-list)
    /// - Returns: Movie genre list
    static func movieGenres(language: Locale? = nil) async throws(TMDBRequestError) -> TMDB.GenreList {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.GenreList>(
            endpoint: V3Endpoints.Genres.movieList(language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/genre/tv/list`
    /// [API Documentation](https://developer.themoviedb.org/reference/genre-tv-list)
    /// - Returns: TV genre list
    static func tvGenres(language: Locale? = nil) async throws(TMDBRequestError) -> TMDB.GenreList {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.GenreList>(
            endpoint: V3Endpoints.Genres.tvList(language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
