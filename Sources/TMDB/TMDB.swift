import Dependencies
import Foundation
import RequestService

public struct TMDB {
    enum Constants {
        static let baseURL = URL(string: "https://api.themoviedb.org")!
    }

    init() {}
}

extension TMDB {
    enum Endpoint {
        enum v3 {
            case movieDetails
        }
    }
}

extension TMDB.Endpoint.v3 {
    var path: String {
        switch self {
        case .movieDetails:
            "3/movie/"
        }
    }
}

public extension TMDB {
    func movieDetails(movieID: Int) async throws -> TMDB.Movie.Details {
        let path = TMDB.Endpoint.v3.movieDetails.path
        let endpoint = HTTP.DynamicURLEndpoint<HTTP.EmptyRequestBody, TMDB.Movie.Details>(
            baseURL: Constants.baseURL,
            method: .get,
        )
        let request = try endpoint.makeURLRequest { components in
            var components = components
            components.path += (path + movieID.formatted(.number.grouping(.never)))
            return components
        }
        return try await endpoint.responseObject(from: request)
    }
}

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
