import Foundation
import TMDB

enum CreditRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/credit/\\d+$") {
                try TMDB.Credits.Details.mockData()
            },
        ]
    }
}
