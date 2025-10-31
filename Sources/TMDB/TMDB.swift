import Dependencies
import Foundation
import RequestService

public enum TMDB {}



// public struct TMDB {
//    let httpClient: HTTP.Client
//
//    public init(authToken: String) {
//        httpClient = HTTP.Client(authToken: authToken)
//    }
//
//    let discover = Discover()
//    let configuration = Configuration()
// }
//
// public extension TMDB {
//    enum v3 {}
// }
//
//// MARK: - Discover endpoints
//
// public extension TMDB {
//    func discoverMovie(with options: [TMDBDiscoverMovieFilter] = []) async throws -> TMDB.Discover.MovieResponse {
//        let request = try discover.movie.makeURLRequest(with: options.map(\.encoded))
//        return try await Endpoint.responseObject(from: request, using: httpClient)
//    }
//
//    func discoverTV(with options: [TMDBDiscoverTVFilter] = []) async throws -> TMDB.Discover.TVResponse {
//        let request = try discover.tv.makeURLRequest(with: options.map(\.encoded))
//        return try await Endpoint.responseObject(from: request, using: httpClient)
//    }
// }
//
//// MARK: - Configuration
//
// public extension TMDB {
//    func apiConfiguration() async throws -> TMDB.Configuration.ApiResponse {
//        let request = try configuration.api.makeURLRequest()
//        return try await Endpoint.responseObject(from: request, using: httpClient)
//    }
// }
