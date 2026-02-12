import Foundation
import TMDB

enum TVSeriesRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            // Sub-endpoints (must come before details match)
            MockRoute(pattern: "^/3/tv/\\d+/aggregate_credits$") {
                try TMDB.AggregateCredits.mockData()
            },
            MockRoute(pattern: "^/3/tv/\\d+/alternative_titles$") {
                try MockUtilities.jsonDataFromFile("AlternativeTVSeriesTitles")
            },
            MockRoute(pattern: "^/3/tv/\\d+/changes$") {
                try MockUtilities.jsonDataFromFile("TVSeriesChanges")
            },
            MockRoute(pattern: "^/3/tv/\\d+/content_ratings$") {
                try MockUtilities.jsonDataFromFile("TVSeriesContentRatings")
            },
            MockRoute(pattern: "^/3/tv/\\d+/credits$") {
                try MockUtilities.jsonDataFromFile("TVSeriesCredits")
            },
            MockRoute(pattern: "^/3/tv/\\d+/episode_groups$") {
                try MockUtilities.jsonDataFromFile("TVSeriesEpisodeGroups")
            },
            MockRoute(pattern: "^/3/tv/\\d+/external_ids$") {
                try MockUtilities.jsonDataFromFile("TVSeriesExternalIDs")
            },
            MockRoute(pattern: "^/3/tv/\\d+/images$") {
                try MockUtilities.jsonDataFromFile("TVSeriesImages")
            },
            MockRoute(pattern: "^/3/tv/\\d+/keywords$") {
                try MockUtilities.jsonDataFromFile("TVSeriesKeywords")
            },
            MockRoute(pattern: "^/3/tv/\\d+/recommendations$") {
                try MockUtilities.jsonDataFromFile("TVSeriesRecommendations")
            },
            MockRoute(pattern: "^/3/tv/\\d+/reviews$") {
                try MockUtilities.jsonDataFromFile("TVSeriesReviews")
            },
            MockRoute(pattern: "^/3/tv/\\d+/screened_theatrically$") {
                try MockUtilities.jsonDataFromFile("TVSeriesScreenedTheatrically")
            },
            MockRoute(pattern: "^/3/tv/\\d+/similar$") {
                try MockUtilities.jsonDataFromFile("SimilarTVSeries")
            },
            MockRoute(pattern: "^/3/tv/\\d+/translations$") {
                try MockUtilities.jsonDataFromFile("TVSeriesTranslations")
            },
            MockRoute(pattern: "^/3/tv/\\d+/videos$") {
                try MockUtilities.jsonDataFromFile("TVSeriesVideos")
            },
            MockRoute(pattern: "^/3/tv/\\d+/watch/providers$") {
                try MockUtilities.jsonDataFromFile("TVSeriesWatchProviders")
            },
            // Details (must come after sub-endpoints)
            MockRoute(pattern: "^/3/tv/\\d+$") {
                try TMDB.TVSeries.mockData()
            },
            // List endpoints
            MockRoute(pattern: "^/3/tv/latest$") {
                try MockUtilities.jsonDataFromFile("TVSeriesLatest")
            },
            MockRoute(pattern: "^/3/tv/airing_today$") {
                try MockUtilities.jsonDataFromFile("TVSeriesAiringToday")
            },
            MockRoute(pattern: "^/3/tv/on_the_air$") {
                try MockUtilities.jsonDataFromFile("TVSeriesOnTheAir")
            },
            MockRoute(pattern: "^/3/tv/popular$") {
                try MockUtilities.jsonDataFromFile("PopularTVSeries")
            },
            MockRoute(pattern: "^/3/tv/top_rated$") {
                try MockUtilities.jsonDataFromFile("TopRatedTVSeries")
            },
        ]
    }
}
