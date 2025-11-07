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
            paths.append(String(id))
        case .alternativeTitles(let id):
            paths += [String(id), "alternative_titles"]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

// MARK: Public /3/movie/ endpoints
public extension TMDB {
    static func movieDetails(_ id: Int) async throws -> Movie {
        let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, TMDB.Movie>(
            endpoint: V3Endpoints.Movies.details(id: id),
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    static func alternativeMovieTitles(_ id: Int) async throws -> [AlternativeTitle] {
        let endpoint = TMDBEndpoint<HTTP.EmptyRequestBody, AlternativeMovieTitlesResponse>(
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

    static func alternativeMovieTitles(movie: Movie) async throws -> [AlternativeTitle] {
        try await alternativeMovieTitles(movie.id)
    }
}
