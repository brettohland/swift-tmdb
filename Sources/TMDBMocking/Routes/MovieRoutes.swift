import Foundation
import TMDB

enum MovieRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            // Sub-endpoints (must come before details match)
            MockRoute(pattern: "^/3/movie/\\d+/alternative_titles$") {
                try TMDB.AlternativeTitle.mockData()
            },
            MockRoute(pattern: "^/3/movie/\\d+/changes$") {
                try TMDB.ChangeCollection.mockData()
            },
            MockRoute(pattern: "^/3/movie/\\d+/credits$") {
                try TMDB.MediaCredits.mockData()
            },
            MockRoute(pattern: "^/3/movie/\\d+/external_ids$") {
                try TMDB.ExternalIDs.mockData()
            },
            MockRoute(pattern: "^/3/movie/\\d+/images$") {
                try TMDB.ImageCollection.mockData()
            },
            MockRoute(pattern: "^/3/movie/\\d+/keywords$") {
                try MockUtilities.jsonDataFromFile("MovieKeywords")
            },
            MockRoute(pattern: "^/3/movie/\\d+/recommendations$") {
                try MockUtilities.jsonDataFromFile("MovieRecommendations")
            },
            MockRoute(pattern: "^/3/movie/\\d+/release_dates$") {
                try MockUtilities.jsonDataFromFile("MovieReleaseDates")
            },
            MockRoute(pattern: "^/3/movie/\\d+/reviews$") {
                try MockUtilities.jsonDataFromFile("MovieReviews")
            },
            MockRoute(pattern: "^/3/movie/\\d+/similar$") {
                try MockUtilities.jsonDataFromFile("SimilarMovies")
            },
            MockRoute(pattern: "^/3/movie/\\d+/translations$") {
                try TMDB.TranslationCollection.mockData()
            },
            MockRoute(pattern: "^/3/movie/\\d+/videos$") {
                try TMDB.VideoCollection.mockData()
            },
            MockRoute(pattern: "^/3/movie/\\d+/watch/providers$") {
                try TMDB.MediaWatchProviderResult.mockData()
            },
            // Details (must come after sub-endpoints)
            MockRoute(pattern: "^/3/movie/\\d+$") {
                try TMDB.Movie.mockData()
            },
            // List endpoints
            MockRoute(pattern: "^/3/movie/latest$") {
                try MockUtilities.jsonDataFromFile("MovieLatest")
            },
            MockRoute(pattern: "^/3/movie/now_playing$") {
                try MockUtilities.jsonDataFromFile("MoviesNowPlaying")
            },
            MockRoute(pattern: "^/3/movie/popular$") {
                try MockUtilities.jsonDataFromFile("PopularMovies")
            },
            MockRoute(pattern: "^/3/movie/top_rated$") {
                try MockUtilities.jsonDataFromFile("TopRatedMovies")
            },
            MockRoute(pattern: "^/3/movie/upcoming$") {
                try MockUtilities.jsonDataFromFile("UpcomingMovies")
            },
        ]
    }
}
