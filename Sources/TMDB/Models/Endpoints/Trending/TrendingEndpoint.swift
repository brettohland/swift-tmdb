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
        case all(timeWindow: TMDB.TrendingTimeWindow)
        case movie(timeWindow: TMDB.TrendingTimeWindow)
        case tv(timeWindow: TMDB.TrendingTimeWindow)
        case person(timeWindow: TMDB.TrendingTimeWindow)
    }
}

extension TMDB.V3Endpoints.Trending: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "trending"]
        switch self {
        case .all(let timeWindow):
            // /3/trending/all/{time_window}
            paths += ["all", timeWindow.rawValue]
        case .movie(let timeWindow):
            // /3/trending/movie/{time_window}
            paths += ["movie", timeWindow.rawValue]
        case .tv(let timeWindow):
            // /3/trending/tv/{time_window}
            paths += ["tv", timeWindow.rawValue]
        case .person(let timeWindow):
            // /3/trending/person/{time_window}
            paths += ["person", timeWindow.rawValue]
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

public extension TMDB {
    /// `/3/trending/all/{time_window}`
    /// [API Documentation](https://developer.themoviedb.org/reference/trending-all)
    /// - Parameter timeWindow: Time window (day or week)
    /// - Returns: Paginated list of trending media
    static func trendingAll(timeWindow: TrendingTimeWindow) async throws(TMDBRequestError) -> TMDB.Discover
    .PaginatedResponse<TMDB.TrendingResult> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.TrendingResult>>(
            endpoint: V3Endpoints.Trending.all(timeWindow: timeWindow),
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
    /// - Parameter timeWindow: Time window (day or week)
    /// - Returns: Paginated list of trending movies
    static func trendingMovies(timeWindow: TrendingTimeWindow) async throws(TMDBRequestError) -> TMDB.Discover
    .PaginatedResponse<TMDB.Discover.DiscoverMovie> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>>(
            endpoint: V3Endpoints.Trending.movie(timeWindow: timeWindow),
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
    /// - Parameter timeWindow: Time window (day or week)
    /// - Returns: Paginated list of trending TV shows
    static func trendingTV(timeWindow: TrendingTimeWindow) async throws(TMDBRequestError) -> TMDB.Discover
    .PaginatedResponse<TMDB.Discover.DiscoverTV> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>>(
            endpoint: V3Endpoints.Trending.tv(timeWindow: timeWindow),
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
    /// - Parameter timeWindow: Time window (day or week)
    /// - Returns: Paginated list of trending people
    static func trendingPeople(timeWindow: TrendingTimeWindow) async throws(TMDBRequestError) -> TMDB.Discover
    .PaginatedResponse<TMDB.TrendingPerson> {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.Discover.PaginatedResponse<TMDB.TrendingPerson>>(
            endpoint: V3Endpoints.Trending.person(timeWindow: timeWindow),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
