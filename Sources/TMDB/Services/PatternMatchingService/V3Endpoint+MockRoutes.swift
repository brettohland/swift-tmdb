import Foundation

// MARK: - Configuration

extension TMDB.V3Endpoints.Configuration: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/configuration$") {
                try TMDB.ConfigurationResponse.mockData()
            },
            MockRoute(pattern: "^/3/configuration/countries$") {
                try CountriesResponse.mockData()
            },
            MockRoute(pattern: "^/3/configuration/jobs$") {
                try TMDB.Configuration.JobDepartment.mockData()
            },
            MockRoute(pattern: "^/3/configuration/languages$") {
                try TMDB.Configuration.Language.mockData()
            },
            MockRoute(pattern: "^/3/configuration/primary_translations$") {
                try MockUtilities.jsonDataFromFile("PrimaryTranslations")
            },
            MockRoute(pattern: "^/3/configuration/timezones$") {
                try TMDB.Configuration.Timezone.mockData()
            },
        ]
    }
}

// MARK: - Certifications

extension TMDB.V3Endpoints.Certifications: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/certification/movie/list$") {
                try TMDB.MovieCertifications.mockData()
            },
            MockRoute(pattern: "^/3/certification/tv/list$") {
                try TMDB.TVCertifications.mockData()
            },
        ]
    }
}

// MARK: - Credits

extension TMDB.V3Endpoints.Credits: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/credit/\\d+$") {
                try TMDB.Credits.Details.mockData()
            },
        ]
    }
}

// MARK: - Discover

extension TMDB.V3Endpoints.Discover: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/discover/movie$") {
                let movie = try TMDB.Discover.DiscoverMovie.mock()
                let response = TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverMovie>(
                    page: 1,
                    totalResults: 1,
                    totalPages: 1,
                    results: [movie],
                )
                return try JSONEncoder().encode(response)
            },
            MockRoute(pattern: "^/3/discover/tv$") {
                let show = try TMDB.Discover.DiscoverTV.mock()
                let response = TMDB.Discover.PaginatedResponse<TMDB.Discover.DiscoverTV>(
                    page: 1,
                    totalResults: 1,
                    totalPages: 1,
                    results: [show],
                )
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                return try encoder.encode(response)
            },
        ]
    }
}

// MARK: - Genres

extension TMDB.V3Endpoints.Genres: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/genre/movie/list$") {
                try TMDB.GenreList.mockData()
            },
            MockRoute(pattern: "^/3/genre/tv/list$") {
                try MockUtilities.jsonDataFromFile("TVGenres")
            },
        ]
    }
}

// MARK: - Movies

extension TMDB.V3Endpoints.Movies: MockRouteProvider {
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
                try TMDB.MovieCredits.mockData()
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
                try MockUtilities.jsonDataFromFile("MovieTranslations")
            },
            MockRoute(pattern: "^/3/movie/\\d+/videos$") {
                try TMDB.VideoCollection.mockData()
            },
            MockRoute(pattern: "^/3/movie/\\d+/watch/providers$") {
                try TMDB.MovieWatchProviderResult.mockData()
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

// MARK: - Reviews

extension TMDB.V3Endpoints.Reviews: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/review/[a-zA-Z0-9]+$") {
                try TMDB.Review.mockData()
            },
        ]
    }
}

// MARK: - Trending

extension TMDB.V3Endpoints.Trending: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/trending/all/(?:day|week)$") {
                try MockUtilities.jsonDataFromFile("TrendingAll")
            },
            MockRoute(pattern: "^/3/trending/movie/(?:day|week)$") {
                try MockUtilities.jsonDataFromFile("TrendingMovies")
            },
            MockRoute(pattern: "^/3/trending/tv/(?:day|week)$") {
                try MockUtilities.jsonDataFromFile("TrendingTV")
            },
            MockRoute(pattern: "^/3/trending/person/(?:day|week)$") {
                try MockUtilities.jsonDataFromFile("TrendingPeople")
            },
        ]
    }
}

// MARK: - WatchProviders

extension TMDB.V3Endpoints.WatchProviders: MockRouteProvider {
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
