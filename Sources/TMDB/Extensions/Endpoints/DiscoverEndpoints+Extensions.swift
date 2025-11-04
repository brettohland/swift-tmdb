import Foundation
import RequestService
import SharedModels

extension TMDBInternal.V3Endpoints.Discover: EndpointFactory {
    public func makeURL(baseURL: URL) -> URL {
        // /3/discover
        var paths = ["3", "discover"]
        var queryItems: [URLQueryItem] = []
        switch self {
        case .movie(let filters):
            // /3/discover/movie
            paths.append("movie")
            queryItems = filters.map(\.queryItem)
        case .tv(let filters):
            // /3/discover/tv
            paths.append("tv")
            queryItems = filters.map(\.queryItem)
        }
        return URLFactory.makeURL(baseURL: baseURL, appending: paths, queryItems: queryItems)
    }
}
