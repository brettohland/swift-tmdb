import Foundation
import TMDB

enum CollectionRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            // Sub-endpoint must come before details
            MockRoute(pattern: "^/3/collection/\\d+/images$") {
                try MockUtilities.jsonDataFromFile("CollectionImages")
            },
            MockRoute(pattern: "^/3/collection/\\d+$") {
                try TMDB.Collection.mockData()
            },
        ]
    }
}
