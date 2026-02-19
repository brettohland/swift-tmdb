internal import Dependencies
import Foundation

extension TMDB.V4Endpoints {
    enum Account {
        case lists(accountID: String, page: Int)
        case favoriteMovies(accountID: String, sortBy: TMDB.Account.SortOrder?, page: Int, language: Locale?)
        case favoriteTVSeries(accountID: String, sortBy: TMDB.Account.SortOrder?, page: Int, language: Locale?)
        case ratedMovies(accountID: String, sortBy: TMDB.Account.SortOrder?, page: Int, language: Locale?)
        case ratedTVSeries(accountID: String, sortBy: TMDB.Account.SortOrder?, page: Int, language: Locale?)
        case movieRecommendations(accountID: String, page: Int, language: Locale?)
        case tvRecommendations(accountID: String, page: Int, language: Locale?)
        case watchlistMovies(accountID: String, page: Int)
        case watchlistTVSeries(accountID: String, page: Int)
    }
}

extension TMDB.V4Endpoints.Account: EndpointFactory {
    var supportsLanguage: Bool {
        switch self {
        case .lists,
             .watchlistMovies,
             .watchlistTVSeries:
            false
        default:
            true
        }
    }

    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["4", "account"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .lists(let accountID, let page):
            paths.append(accountID)
            paths.append("lists")
            queryItems.append(.page, value: page)
        case .favoriteMovies(let accountID, let sortBy, let page, let language):
            paths.append(accountID)
            paths.append("movie")
            paths.append("favorites")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.sortBy, value: sortBy)
            queryItems.appendIfPresent(.language, value: language)
        case .favoriteTVSeries(let accountID, let sortBy, let page, let language):
            paths.append(accountID)
            paths.append("tv")
            paths.append("favorites")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.sortBy, value: sortBy)
            queryItems.appendIfPresent(.language, value: language)
        case .ratedMovies(let accountID, let sortBy, let page, let language):
            paths.append(accountID)
            paths.append("movie")
            paths.append("rated")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.sortBy, value: sortBy)
            queryItems.appendIfPresent(.language, value: language)
        case .ratedTVSeries(let accountID, let sortBy, let page, let language):
            paths.append(accountID)
            paths.append("tv")
            paths.append("rated")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.sortBy, value: sortBy)
            queryItems.appendIfPresent(.language, value: language)
        case .movieRecommendations(let accountID, let page, let language):
            paths.append(accountID)
            paths.append("movie")
            paths.append("recommendations")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .tvRecommendations(let accountID, let page, let language):
            paths.append(accountID)
            paths.append("tv")
            paths.append("recommendations")
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .watchlistMovies(let accountID, let page):
            paths.append(accountID)
            paths.append("movie")
            paths.append("watchlist")
            queryItems.append(.page, value: page)
        case .watchlistTVSeries(let accountID, let page):
            paths.append(accountID)
            paths.append("tv")
            paths.append("watchlist")
            queryItems.append(.page, value: page)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

// MARK: - Account Lists

public extension TMDB {
    /// `GET /4/account/{account_object_id}/lists`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-lists)
    /// - Parameter page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Account/AccountList``
    /// - Throws: ``TMDBRequestError``
    static func accountLists(
        page: Int = 1,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Account.AccountList> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Account.AccountList>>(
            endpoint: V4Endpoints.Account.lists(accountID: session.accountID, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Favorite Movies

public extension TMDB {
    /// `GET /4/account/{account_object_id}/movie/favorites`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-favorite-movies)
    /// - Parameters:
    ///   - sortBy: Sort order for results
    ///   - page: The page of results to return (default: 1)
    ///   - language: Language for the response
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func favoriteMovies(
        sortBy: Account.SortOrder? = nil,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverMovie> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Discover.DiscoverMovie>>(
            endpoint: V4Endpoints.Account.favoriteMovies(
                accountID: session.accountID,
                sortBy: sortBy,
                page: page,
                language: language,
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

// MARK: - Favorite TV Series

public extension TMDB {
    /// `GET /4/account/{account_object_id}/tv/favorites`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-favorite-tv)
    /// - Parameters:
    ///   - sortBy: Sort order for results
    ///   - page: The page of results to return (default: 1)
    ///   - language: Language for the response
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func favoriteTVSeries(
        sortBy: Account.SortOrder? = nil,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Discover.DiscoverTV>>(
            endpoint: V4Endpoints.Account.favoriteTVSeries(
                accountID: session.accountID,
                sortBy: sortBy,
                page: page,
                language: language,
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

// MARK: - Rated Movies

public extension TMDB {
    /// `GET /4/account/{account_object_id}/movie/rated`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-rated-movies)
    /// - Parameters:
    ///   - sortBy: Sort order for results
    ///   - page: The page of results to return (default: 1)
    ///   - language: Language for the response
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Account/RatedMovie``
    /// - Throws: ``TMDBRequestError``
    static func ratedMovies(
        sortBy: Account.SortOrder? = nil,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Account.RatedMovie> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Account.RatedMovie>>(
            endpoint: V4Endpoints.Account.ratedMovies(
                accountID: session.accountID,
                sortBy: sortBy,
                page: page,
                language: language,
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

// MARK: - Rated TV Series

public extension TMDB {
    /// `GET /4/account/{account_object_id}/tv/rated`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-rated-tv)
    /// - Parameters:
    ///   - sortBy: Sort order for results
    ///   - page: The page of results to return (default: 1)
    ///   - language: Language for the response
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Account/RatedTV``
    /// - Throws: ``TMDBRequestError``
    static func ratedTVSeries(
        sortBy: Account.SortOrder? = nil,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Account.RatedTV> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Account.RatedTV>>(
            endpoint: V4Endpoints.Account.ratedTVSeries(
                accountID: session.accountID,
                sortBy: sortBy,
                page: page,
                language: language,
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

// MARK: - Movie Recommendations

public extension TMDB {
    /// `GET /4/account/{account_object_id}/movie/recommendations`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-movie-recommendations)
    /// - Parameters:
    ///   - page: The page of results to return (default: 1)
    ///   - language: Language for the response
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func accountMovieRecommendations(
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverMovie> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Discover.DiscoverMovie>>(
            endpoint: V4Endpoints.Account.movieRecommendations(
                accountID: session.accountID,
                page: page,
                language: language,
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

// MARK: - TV Recommendations

public extension TMDB {
    /// `GET /4/account/{account_object_id}/tv/recommendations`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-tv-recommendations)
    /// - Parameters:
    ///   - page: The page of results to return (default: 1)
    ///   - language: Language for the response
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func accountTVRecommendations(
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Discover.DiscoverTV>>(
            endpoint: V4Endpoints.Account.tvRecommendations(
                accountID: session.accountID,
                page: page,
                language: language,
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

// MARK: - Watchlist Movies

public extension TMDB {
    /// `GET /4/account/{account_object_id}/movie/watchlist`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-movie-watchlist)
    /// - Parameter page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverMovie``
    /// - Throws: ``TMDBRequestError``
    static func watchlistMovies(
        page: Int = 1,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverMovie> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Discover.DiscoverMovie>>(
            endpoint: V4Endpoints.Account.watchlistMovies(accountID: session.accountID, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}

// MARK: - Watchlist TV Series

public extension TMDB {
    /// `GET /4/account/{account_object_id}/tv/watchlist`
    ///
    /// [TMDB API Documentation](https://developer.themoviedb.org/v4/reference/account-tv-watchlist)
    /// - Parameter page: The page of results to return (default: 1)
    /// - Returns: ``TMDB/Discover/PaginatedResponse`` of ``TMDB/Discover/DiscoverTV``
    /// - Throws: ``TMDBRequestError``
    static func watchlistTVSeries(
        page: Int = 1,
    ) async throws(TMDBRequestError) -> Discover.PaginatedResponse<Discover.DiscoverTV> {
        @Dependency(\.authSessionStore) var sessionStore
        guard let session = sessionStore.load() else { throw .notAuthenticated }
        let endpoint = Endpoint<HTTP.EmptyRequestBody, Discover.PaginatedResponse<Discover.DiscoverTV>>(
            endpoint: V4Endpoints.Account.watchlistTVSeries(accountID: session.accountID, page: page),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
