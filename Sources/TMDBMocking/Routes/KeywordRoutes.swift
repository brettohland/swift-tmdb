import Foundation
import TMDB

enum KeywordRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            // Sub-endpoint must come before details
            MockRoute(pattern: "^/3/keyword/\\d+/movies$") {
                try MockUtilities.jsonDataFromFile("KeywordMovies")
            },
            MockRoute(pattern: "^/3/keyword/\\d+$") {
                try TMDB.Keyword.mockData()
            },
        ]
    }
}
