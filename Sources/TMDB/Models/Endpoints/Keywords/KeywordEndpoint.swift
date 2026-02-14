import Foundation

extension TMDB.V3Endpoints {
    enum Keywords {
        case details(id: Int)
        case movies(id: Int, page: Int)
    }
}

extension TMDB.V3Endpoints.Keywords: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "keyword"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .details(let id):
            // /3/keyword/{id}
            paths.append(String(id))
        case .movies(let id, let page):
            // /3/keyword/{id}/movies
            paths += [String(id), "movies"]
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Keyword Details

public extension TMDB {
    /// `/3/keyword/{id}`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/keyword-details)
    /// - Parameter id: The keyword ID
    /// - Returns: ``TMDB/Keyword``
    /// - Throws: ``TMDBRequestError``
    static func keywordDetails(id: Int) async throws(TMDBRequestError) -> Keyword {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Keyword>(
            endpoint: V3Endpoints.Keywords.details(id: id),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Keyword Movies

public extension TMDB {
    /// `/3/keyword/{id}/movies`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/keyword-movies)
    /// - Parameters:
    ///   - id: The keyword ID
    ///   - page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func keywordMovies(id: Int, page: Int = 1) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Keywords.movies(id: id, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
