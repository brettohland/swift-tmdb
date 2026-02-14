import Foundation

extension TMDB.V3Endpoints {
    enum Search {
        case movie(query: String, page: Int, includeAdult: Bool, year: Int?, primaryReleaseYear: Int?)
        case tv(query: String, page: Int, includeAdult: Bool, firstAirDateYear: Int?)
        case person(query: String, page: Int, includeAdult: Bool)
        case multi(query: String, page: Int, includeAdult: Bool)
        case collection(query: String, page: Int)
        case company(query: String, page: Int)
        case keyword(query: String, page: Int)
    }
}

extension TMDB.V3Endpoints.Search: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "search"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .movie(let query, let page, let includeAdult, let year, let primaryReleaseYear):
            paths.append("movie")
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
            if includeAdult {
                queryItems.append(URLQueryItem(name: "include_adult", value: "true"))
            }
            if let year {
                queryItems.append(URLQueryItem(name: "year", value: String(year)))
            }
            if let primaryReleaseYear {
                queryItems.append(URLQueryItem(name: "primary_release_year", value: String(primaryReleaseYear)))
            }
        case .tv(let query, let page, let includeAdult, let firstAirDateYear):
            paths.append("tv")
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
            if includeAdult {
                queryItems.append(URLQueryItem(name: "include_adult", value: "true"))
            }
            if let firstAirDateYear {
                queryItems.append(URLQueryItem(name: "first_air_date_year", value: String(firstAirDateYear)))
            }
        case .person(let query, let page, let includeAdult):
            paths.append("person")
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
            if includeAdult {
                queryItems.append(URLQueryItem(name: "include_adult", value: "true"))
            }
        case .multi(let query, let page, let includeAdult):
            paths.append("multi")
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
            if includeAdult {
                queryItems.append(URLQueryItem(name: "include_adult", value: "true"))
            }
        case .collection(let query, let page):
            paths.append("collection")
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        case .company(let query, let page):
            paths.append("company")
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        case .keyword(let query, let page):
            paths.append("keyword")
            queryItems.append(URLQueryItem(name: "query", value: query))
            queryItems.append(URLQueryItem(name: "page", value: String(page)))
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Search Movies

public extension TMDB {
    /// `/3/search/movie`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/search-movie)
    /// - Parameters:
    ///   - query: The search query string
    ///   - page: The page of results to return (default: 1)
    ///   - includeAdult: Whether to include adult content in results (default: false)
    ///   - year: Filter results by release year
    ///   - primaryReleaseYear: Filter results by primary release year
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func searchMovies(
        query: String,
        page: Int = 1,
        includeAdult: Bool = false,
        year: Int? = nil,
        primaryReleaseYear: Int? = nil,
    ) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Search.movie(
                query: query,
                page: page,
                includeAdult: includeAdult,
                year: year,
                primaryReleaseYear: primaryReleaseYear,
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

// MARK: - Search TV

public extension TMDB {
    /// `/3/search/tv`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/search-tv)
    /// - Parameters:
    ///   - query: The search query string
    ///   - page: The page of results to return (default: 1)
    ///   - includeAdult: Whether to include adult content in results (default: false)
    ///   - firstAirDateYear: Filter results by first air date year
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func searchTV(
        query: String,
        page: Int = 1,
        includeAdult: Bool = false,
        firstAirDateYear: Int? = nil,
    ) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.Search.tv(
                query: query,
                page: page,
                includeAdult: includeAdult,
                firstAirDateYear: firstAirDateYear,
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

// MARK: - Search People

public extension TMDB {
    /// `/3/search/person`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/search-person)
    /// - Parameters:
    ///   - query: The search query string
    ///   - page: The page of results to return (default: 1)
    ///   - includeAdult: Whether to include adult content in results (default: false)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/SearchPerson``
    /// - Throws: ``TMDBRequestError``
    static func searchPeople(
        query: String,
        page: Int = 1,
        includeAdult: Bool = false,
    ) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<SearchPerson> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.SearchPerson>>(
            endpoint: V3Endpoints.Search.person(query: query, page: page, includeAdult: includeAdult),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Search Multi

public extension TMDB {
    /// `/3/search/multi`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/search-multi)
    /// - Parameters:
    ///   - query: The search query string
    ///   - page: The page of results to return (default: 1)
    ///   - includeAdult: Whether to include adult content in results (default: false)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/MultiSearchResult``
    /// - Throws: ``TMDBRequestError``
    static func searchMulti(
        query: String,
        page: Int = 1,
        includeAdult: Bool = false,
    ) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<MultiSearchResult> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.MultiSearchResult>>(
            endpoint: V3Endpoints.Search.multi(query: query, page: page, includeAdult: includeAdult),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Search Collections

public extension TMDB {
    /// `/3/search/collection`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/search-collection)
    /// - Parameters:
    ///   - query: The search query string
    ///   - page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/SearchCollection``
    /// - Throws: ``TMDBRequestError``
    static func searchCollections(query: String, page: Int = 1) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<SearchCollection> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.SearchCollection>>(
            endpoint: V3Endpoints.Search.collection(query: query, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Search Companies

public extension TMDB {
    /// `/3/search/company`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/search-company)
    /// - Parameters:
    ///   - query: The search query string
    ///   - page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/SearchCompany``
    /// - Throws: ``TMDBRequestError``
    static func searchCompanies(query: String, page: Int = 1) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<SearchCompany> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.SearchCompany>>(
            endpoint: V3Endpoints.Search.company(query: query, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Search Keywords

public extension TMDB {
    /// `/3/search/keyword`
    ///
    /// [API Documentation on TMDB](https://developer.themoviedb.org/reference/search-keyword)
    /// - Parameters:
    ///   - query: The search query string
    ///   - page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Keyword``
    /// - Throws: ``TMDBRequestError``
    static func searchKeywords(query: String, page: Int = 1) async throws(TMDBRequestError) -> Discover
    .PaginatedResponse<Keyword> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Keyword>>(
            endpoint: V3Endpoints.Search.keyword(query: query, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
