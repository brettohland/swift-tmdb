import Foundation

extension TMDB.V3Endpoints {
    enum WatchProviders {
        case regions
        case movie
        case tv
    }
}

extension TMDB.V3Endpoints.WatchProviders: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "watch", "providers"]
        switch self {
        case .regions:
            // /3/watch/providers/regions
            paths.append("regions")
        case .movie:
            // /3/watch/providers/movie
            paths.append("movie")
        case .tv:
            // /3/watch/providers/tv
            paths.append("tv")
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths)
    }
}

public extension TMDB {
    /// `/3/watch/providers/regions`
    /// [API Documentation](https://developer.themoviedb.org/reference/watch-providers-available-regions)
    /// - Returns: Available regions for watch providers
    static func watchProviderRegions() async throws -> TMDB.WatchProviderRegions {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.WatchProviderRegions>(
            endpoint: V3Endpoints.WatchProviders.regions,
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    /// `/3/watch/providers/movie`
    /// [API Documentation](https://developer.themoviedb.org/reference/watch-providers-movie-list)
    /// - Returns: Movie watch providers
    static func movieWatchProviders() async throws -> TMDB.WatchProviderList {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.WatchProviderList>(
            endpoint: V3Endpoints.WatchProviders.movie,
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }

    /// `/3/watch/providers/tv`
    /// [API Documentation](https://developer.themoviedb.org/reference/watch-providers-tv-list)
    /// - Returns: TV watch providers
    static func tvWatchProviders() async throws -> TMDB.WatchProviderList {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.WatchProviderList>(
            endpoint: V3Endpoints.WatchProviders.tv,
            httpMethod: .get,
        )
        return try await endpoint.decodedResponse()
    }
}
