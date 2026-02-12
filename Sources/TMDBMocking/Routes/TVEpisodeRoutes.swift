import Foundation
import TMDB

enum TVEpisodeRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            // Sub-endpoints (must come before details match)
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/episode/\\d+/credits$") {
                try MockUtilities.jsonDataFromFile("TVEpisodeCredits")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/episode/\\d+/external_ids$") {
                try MockUtilities.jsonDataFromFile("TVEpisodeExternalIDs")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/episode/\\d+/images$") {
                try MockUtilities.jsonDataFromFile("TVEpisodeImages")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/episode/\\d+/translations$") {
                try MockUtilities.jsonDataFromFile("TVEpisodeTranslations")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/episode/\\d+/videos$") {
                try MockUtilities.jsonDataFromFile("TVEpisodeVideos")
            },
            // Details (must come after sub-endpoints)
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/episode/\\d+$") {
                try TMDB.TVEpisode.mockData()
            },
            // Changes (uses episode ID directly)
            MockRoute(pattern: "^/3/tv/episode/\\d+/changes$") {
                try MockUtilities.jsonDataFromFile("TVEpisodeChanges")
            },
        ]
    }
}
