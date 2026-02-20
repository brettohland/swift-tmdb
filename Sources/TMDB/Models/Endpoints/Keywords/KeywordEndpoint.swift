import Foundation

extension TMDB.V3Endpoints {
    enum Keywords {
        case details(id: Int)
        case movies(id: Int, page: Int, includeAdult: Bool, language: Locale?, region: Locale.Region?)
    }
}

extension TMDB.V3Endpoints.Keywords: EndpointFactory {
    var supportsLanguage: Bool {
        switch self {
        case .details:
            false
        case .movies:
            true
        }
    }

    var supportsRegion: Bool {
        switch self {
        case .details:
            false
        case .movies:
            true
        }
    }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "keyword"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .details(let id):
            // /3/keyword/{id}
            paths.append(String(id))
        case .movies(let id, let page, let includeAdult, let language, let region):
            // /3/keyword/{id}/movies
            paths += [String(id), "movies"]
            queryItems.append(.page, value: page)
            queryItems.appendIfTrue(.includeAdult, value: includeAdult)
            queryItems.appendIfPresent(.language, value: language)
            queryItems.appendIfPresent(.region, value: region)
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
    ///   - includeAdult: Whether to include adult content in results (default: false)
    ///   - language: The locale for translated content
    ///   - region: The region for regional content
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func keywordMovies(
        id: Int,
        page: Int = 1,
        includeAdult: Bool = false,
        language: Locale? = nil,
        region: Locale.Region? = nil,
    ) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Keywords.movies(
                id: id,
                page: page,
                includeAdult: includeAdult,
                language: language,
                region: region,
            ),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
