import Foundation
import TMDB

enum DiscoverRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/discover/movie$") {
                let movie = try TMDB.Discover.DiscoverMovie.mock()
                let response = TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>(
                    page: 1,
                    totalResults: 1,
                    totalPages: 1,
                    results: [movie],
                )
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                return try encoder.encode(response)
            },
            MockRoute(pattern: "^/3/discover/tv$") {
                let show = try TMDB.Discover.DiscoverTV.mock()
                let response = TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>(
                    page: 1,
                    totalResults: 1,
                    totalPages: 1,
                    results: [show],
                )
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                return try encoder.encode(response)
            },
        ]
    }
}
