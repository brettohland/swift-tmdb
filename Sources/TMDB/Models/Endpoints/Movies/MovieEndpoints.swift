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

// MARK: - Public /3/movie/ endpoints

// MARK: Movie details

public extension TMDB {
    /// `/3/movie/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-details)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: ``TMDB/Movie``
    /// - Throws: ``TMDBRequestError``
    static func movieDetails(id: Int) async throws(TMDBRequestError) -> Movie {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Movie>(
            endpoint: V3Endpoints.Movies.details(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: Alternative Titles

public extension TMDB {
    /// `/3/movie/{id}/alternative_titles`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-alternative-titles)
    /// - Parameter id: `Int` TMDB's unique identifier for the movie
    /// - Returns: An array of ``TMDB/AlternativeTitle`` values
    /// - Throws: ``TMDBRequestError
    static func alternativeMovieTitles(id: Int) async throws(TMDBRequestError) -> [AlternativeTitle] {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, AlternativeMovieTitlesResponse>(
            endpoint: V3Endpoints.Movies.alternativeTitles(id: id),
            httpMethod: .get,
        )
        do {
            let response = try await endpoint.decodedResponse()
            return response.titles
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/movie/{id}/alternative_titles`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/movie-alternative-titles)
    /// - Parameter movie: ``TMDB/Movie``
    /// - Returns: An array of ``TMDB/AlternativeTitle`` values
    /// - Throws: ``TMDBRequestError
    static func alternativeMovieTitles(movie: Movie) async throws(TMDBRequestError) -> [AlternativeTitle] {
        try await alternativeMovieTitles(id: movie.id)
    }
}
