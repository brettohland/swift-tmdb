import Foundation
import TMDB

enum TrendingRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/trending/all/(?:day|week)$") {
                try TMDB.TrendingResult.mockData()
            },
            MockRoute(pattern: "^/3/trending/movie/(?:day|week)$") {
                try MockUtilities.jsonDataFromFile("TrendingMovies")
            },
            MockRoute(pattern: "^/3/trending/tv/(?:day|week)$") {
                try MockUtilities.jsonDataFromFile("TrendingTV")
            },
            MockRoute(pattern: "^/3/trending/person/(?:day|week)$") {
                try TMDB.TrendingPerson.mockData()
            },
        ]
    }
}
