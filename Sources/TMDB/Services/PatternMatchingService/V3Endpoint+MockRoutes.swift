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
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                return try encoder.encode(response)
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

// MARK: - TV Episodes

extension TMDB.V3Endpoints.TVEpisodes: MockRouteProvider {
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

// MARK: - TV Episode Groups

extension TMDB.V3Endpoints.TVEpisodeGroups: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/tv/episode_group/[^/]+$") {
                try TMDB.EpisodeGroupDetails.mockData()
            },
        ]
    }
}

// MARK: - TV Seasons

extension TMDB.V3Endpoints.TVSeasons: MockRouteProvider {
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

// MARK: - TV Series

extension TMDB.V3Endpoints.TVSeries: MockRouteProvider {
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
                try TMDB.TrendingResult.mockData()
            },
            MockRoute(pattern: "^/3/trending/movie/(?:day|week)$") {
                try MockUtilities.jsonDataFromFile("TrendingMovies")
            },
            MockRoute(pattern: "^/3/trending/tv/(?:day|week)$") {
                try MockUtilities.jsonDataFromFile("TrendingTV")
            },
            MockRoute(pattern: "^/3/trending/person/(?:day|week)$") {
                try TMDB.TrendingPerson.mockData()
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

// MARK: - Search

extension TMDB.V3Endpoints.Search: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/search/movie$") {
                try MockUtilities.jsonDataFromFile("SearchMovies")
            },
            MockRoute(pattern: "^/3/search/tv$") {
                try MockUtilities.jsonDataFromFile("SearchTV")
            },
            MockRoute(pattern: "^/3/search/person$") {
                try TMDB.SearchPerson.mockData()
            },
            MockRoute(pattern: "^/3/search/multi$") {
                try TMDB.MultiSearchResult.mockData()
            },
            MockRoute(pattern: "^/3/search/collection$") {
                try TMDB.SearchCollection.mockData()
            },
            MockRoute(pattern: "^/3/search/company$") {
                try TMDB.SearchCompany.mockData()
            },
            MockRoute(pattern: "^/3/search/keyword$") {
                try MockUtilities.jsonDataFromFile("SearchKeywords")
            },
        ]
    }
}

// MARK: - Find

extension TMDB.V3Endpoints.Find: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/find/[^/]+$") {
                try TMDB.FindResult.mockData()
            },
        ]
    }
}

// MARK: - Keywords

extension TMDB.V3Endpoints.Keywords: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            // Sub-endpoint must come before details
            MockRoute(pattern: "^/3/keyword/\\d+/movies$") {
                try MockUtilities.jsonDataFromFile("KeywordMovies")
            },
            MockRoute(pattern: "^/3/keyword/\\d+$") {
                try TMDB.Keyword.mockData()
            },
        ]
    }
}

// MARK: - Collections

extension TMDB.V3Endpoints.Collections: MockRouteProvider {
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
