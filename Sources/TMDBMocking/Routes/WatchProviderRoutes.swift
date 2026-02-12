import Foundation
import TMDB

enum WatchProviderRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/watch/providers/regions$") {
                try TMDB.WatchProviderRegions.mockData()
            },
            MockRoute(pattern: "^/3/watch/providers/movie$") {
                try TMDB.WatchProviderList.mockData()
            },
            MockRoute(pattern: "^/3/watch/providers/tv$") {
                try MockUtilities.jsonDataFromFile("TVProviders")
            },
        ]
    }
}
