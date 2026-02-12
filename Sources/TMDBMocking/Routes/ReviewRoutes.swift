import Foundation
import TMDB

enum ReviewRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/review/[a-zA-Z0-9]+$") {
                try TMDB.Review.mockData()
            },
        ]
    }
}
