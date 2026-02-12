import Foundation
import TMDB

enum TVEpisodeGroupRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/tv/episode_group/[^/]+$") {
                try TMDB.EpisodeGroupDetails.mockData()
            },
        ]
    }
}
