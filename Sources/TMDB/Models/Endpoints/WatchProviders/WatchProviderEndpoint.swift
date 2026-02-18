import Foundation

extension TMDB.V3Endpoints {
    enum WatchProviders {
        case regions(language: Locale?)
        case movie(language: Locale?)
        case tv(language: Locale?)
    }
}

extension TMDB.V3Endpoints.WatchProviders: EndpointFactory {
    func makeURL(baseURL: URL) -> URL {
        var paths: [any StringProtocol] = ["3", "watch", "providers"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .regions(let language):
            // /3/watch/providers/regions
            paths.append("regions")
            queryItems.appendIfPresent(.language, value: language)
        case .movie(let language):
            // /3/watch/providers/movie
            paths.append("movie")
            queryItems.appendIfPresent(.language, value: language)
        case .tv(let language):
            // /3/watch/providers/tv
            paths.append("tv")
            queryItems.appendIfPresent(.language, value: language)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}

public extension TMDB {
    /// `/3/watch/providers/regions`
    /// [API Documentation](https://developer.themoviedb.org/reference/watch-providers-available-regions)
    /// - Returns: Available regions for watch providers
    static func watchProviderRegions(language: Locale? = nil) async throws(TMDBRequestError) -> TMDB
    .WatchProviderRegions {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.WatchProviderRegions>(
            endpoint: V3Endpoints.WatchProviders.regions(language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/watch/providers/movie`
    /// [API Documentation](https://developer.themoviedb.org/reference/watch-providers-movie-list)
    /// - Returns: Movie watch providers
    static func movieWatchProviders(language: Locale? = nil) async throws(TMDBRequestError) -> TMDB.WatchProviderList {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.WatchProviderList>(
            endpoint: V3Endpoints.WatchProviders.movie(language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }

    /// `/3/watch/providers/tv`
    /// [API Documentation](https://developer.themoviedb.org/reference/watch-providers-tv-list)
    /// - Returns: TV watch providers
    static func tvWatchProviders(language: Locale? = nil) async throws(TMDBRequestError) -> TMDB.WatchProviderList {
        let endpoint = Endpoint<HTTP.EmptyRequestBody, TMDB.WatchProviderList>(
            endpoint: V3Endpoints.WatchProviders.tv(language: language),
            httpMethod: .get,
        )
        do {
            return try await endpoint.decodedResponse()
        } catch {
            throw .systemError(error)
        }
    }
}
