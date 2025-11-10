import Foundation

extension TMDB.V3Endpoints {
    enum Movies {
        case details(id: Int)
        case alternativeTitles(id: Int)
    }
}

extension TMDB.V3Endpoints.Movies: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "movie"]
        switch self {
        case .details(let id):
            // /3/movies/{ID}
            paths.append(String(id))
        case .alternativeTitles(let id):
            // /3/movies/{ID}/alternative_titles
            paths += [String(id), "alternative_titles"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

// MARK: Public /3/movie/ endpoints

public extension TMDB {
    /// Make a request to the TMDB API's `/3/movie/{id}` endpoint
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB.Movie``
    /// - Throws: ``TMDBClientError``, ``TMDBServerError``, or ``TMDBRequestError``
    static func movieDetails(_ id: Int) async throws -> Movie {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Movie>(
            endpoint: V3Endpoints.Movies.details(id: id),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    /// Make a request to the TMDB API's `/3/movie/{id}/alternative_titles` endpoint and returns only the
    /// array of alternative titles.
    ///
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``[TMDB.AlternativeTitle]``
    /// - Throws: ``TMDBClientError``, ``TMDBServerError``, or ``TMDBRequestError``
    static func alternativeMovieTitles(_ id: Int) async throws -> [AlternativeTitle] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, AlternativeMovieTitlesResponse>(
            endpoint: V3Endpoints.Movies.alternativeTitles(id: id),
            httpMethod: .get,
        )
        let response = try await endpoint.decodedResponse()

        // Verify that our alternative titles match
        guard response.id == id else {
            throw TMDBRequestError.invalidRequestData
        }
        return response.titles
    }

    /// Make a request to the TMDB API's `/3/movie/{id}/alternative_titles` endpoint and returns only the
    /// array of alternative titles.
    ///
    /// - Parameter movie: ``TMDB.Movie``
    /// - Returns: ``[TMDB.AlternativeTitle]``
    /// - Throws: ``TMDBClientError``, ``TMDBServerError``, or ``TMDBRequestError``
    static func alternativeMovieTitles(movie: Movie) async throws -> [AlternativeTitle] {
        try await alternativeMovieTitles(movie.id)
    }
}
