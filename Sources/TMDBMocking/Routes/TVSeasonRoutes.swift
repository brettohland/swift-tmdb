import Foundation
import TMDB

enum TVSeasonRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            // Sub-endpoints (must come before details match)
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/aggregate_credits$") {
                try MockUtilities.jsonDataFromFile("TVSeasonAggregateCredits")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/credits$") {
                try MockUtilities.jsonDataFromFile("TVSeasonCredits")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/external_ids$") {
                try MockUtilities.jsonDataFromFile("TVSeasonExternalIDs")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/images$") {
                try MockUtilities.jsonDataFromFile("TVSeasonImages")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/translations$") {
                try MockUtilities.jsonDataFromFile("TVSeasonTranslations")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/videos$") {
                try MockUtilities.jsonDataFromFile("TVSeasonVideos")
            },
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+/watch/providers$") {
                try MockUtilities.jsonDataFromFile("TVSeasonWatchProviders")
            },
            // Details (must come after sub-endpoints)
            MockRoute(pattern: "^/3/tv/\\d+/season/\\d+$") {
                try TMDB.TVSeason.mockData()
            },
            // Changes (uses season ID directly)
            MockRoute(pattern: "^/3/tv/season/\\d+/changes$") {
                try MockUtilities.jsonDataFromFile("TVSeasonChanges")
            },
        ]
    }
}
