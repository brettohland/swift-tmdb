import Foundation

public extension TMDB {
    /// Time window for trending content
    enum TrendingTimeWindow: String {
        case day
        case week
    }
}

extension TMDB.V3Endpoints {
    enum Trending {
        case all(timeWindow: TMDB.TrendingTimeWindow, page: Int, language: Locale?)
        case movie(timeWindow: TMDB.TrendingTimeWindow, page: Int, language: Locale?)
        case tv(timeWindow: TMDB.TrendingTimeWindow, page: Int, language: Locale?)
        case person(timeWindow: TMDB.TrendingTimeWindow, page: Int, language: Locale?)
    }
}

extension TMDB.V3Endpoints.Trending: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "trending"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .all(let timeWindow, let page, let language):
            // /3/trending/all/{time_window}
            paths += ["all", timeWindow.rawValue]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .movie(let timeWindow, let page, let language):
            // /3/trending/movie/{time_window}
            paths += ["movie", timeWindow.rawValue]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .tv(let timeWindow, let page, let language):
            // /3/trending/tv/{time_window}
            paths += ["tv", timeWindow.rawValue]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        case .person(let timeWindow, let page, let language):
            // /3/trending/person/{time_window}
            paths += ["person", timeWindow.rawValue]
            queryItems.append(.page, value: page)
            queryItems.appendIfPresent(.language, value: language)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

public extension TMDB {
    /// `/3/trending/all/{time_window}`
    /// [API Documentation](https://developer.themoviedb.org/reference/trending-all)
    /// - Parameters:
    ///   - timeWindow: Time window (day or week)
    ///   - page: The page of results to return (default: 1)
    ///   - language: The locale for translated content
    /// - Returns: Paginated list of trending media
    static func trendingAll(
        timeWindow: TrendingTimeWindow,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> TMDB.Discover
    .PaginatedResponse<TMDB.TrendingResult> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.TrendingResult>>(
            endpoint: V3Endpoints.Trending.all(timeWindow: timeWindow, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/trending/movie/{time_window}`
    /// [API Documentation](https://developer.themoviedb.org/reference/trending-movies)
    /// - Parameters:
    ///   - timeWindow: Time window (day or week)
    ///   - page: The page of results to return (default: 1)
    ///   - language: The locale for translated content
    /// - Returns: Paginated list of trending movies
    static func trendingMovies(
        timeWindow: TrendingTimeWindow,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> TMDB.Discover
    .PaginatedResponse<TMDB.Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Trending.movie(timeWindow: timeWindow, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/trending/tv/{time_window}`
    /// [API Documentation](https://developer.themoviedb.org/reference/trending-tv)
    /// - Parameters:
    ///   - timeWindow: Time window (day or week)
    ///   - page: The page of results to return (default: 1)
    ///   - language: The locale for translated content
    /// - Returns: Paginated list of trending TV shows
    static func trendingTV(
        timeWindow: TrendingTimeWindow,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> TMDB.Discover
    .PaginatedResponse<TMDB.Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.Trending.tv(timeWindow: timeWindow, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/trending/person/{time_window}`
    /// [API Documentation](https://developer.themoviedb.org/reference/trending-people)
    /// - Parameters:
    ///   - timeWindow: Time window (day or week)
    ///   - page: The page of results to return (default: 1)
    ///   - language: The locale for translated content
    /// - Returns: Paginated list of trending people
    static func trendingPeople(
        timeWindow: TrendingTimeWindow,
        page: Int = 1,
        language: Locale? = nil,
    ) async throws(TMDBRequestError) -> TMDB.Discover
    .PaginatedResponse<TMDB.TrendingPerson> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.TrendingPerson>>(
            endpoint: V3Endpoints.Trending.person(timeWindow: timeWindow, page: page, language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
