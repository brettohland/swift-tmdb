import Foundation
import TMDB

enum FindRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/find/[^/]+$") {
                try TMDB.FindResult.mockData()
            },
        ]
    }
}
