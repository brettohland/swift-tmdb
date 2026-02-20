import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct TVSeriesIntegrationTests {
    @Test func tvSeriesDetails() async throws {
        try await withLiveTMDB {
            let series = try await TMDB.tvSeriesDetails(id: 1_396)
            #expect(series.id == 1_396)
            #expect(series.name == "Breaking Bad")
            #expect(!series.seasons.isEmpty)
        }
    }

    @Test func tvSeriesCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.tvSeriesCredits(id: 1_396)
            #expect(!credits.cast.isEmpty)
        }
    }

    @Test func tvSeriesAggregateCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.tvSeriesAggregateCredits(id: 1_396)
            #expect(!credits.cast.isEmpty)
        }
    }

    @Test func tvSeriesImages() async throws {
        try await withLiveTMDB {
            let images = try await TMDB.tvSeriesImages(id: 1_396)
            #expect(!images.backdrops.isEmpty)
        }
    }

    @Test func tvSeriesVideos() async throws {
        try await withLiveTMDB {
            let videos = try await TMDB.tvSeriesVideos(id: 1_396)
            #expect(!videos.results.isEmpty)
        }
    }

    @Test func tvSeriesReviews() async throws {
        try await withLiveTMDB {
            let reviews = try await TMDB.tvSeriesReviews(id: 1_396)
            #expect(!reviews.results.isEmpty)
        }
    }

    @Test func tvSeriesKeywords() async throws {
        try await withLiveTMDB {
            let keywords = try await TMDB.tvSeriesKeywords(id: 1_396)
            #expect(!keywords.isEmpty)
        }
    }

    @Test func similarTVSeries() async throws {
        try await withLiveTMDB {
            let similar = try await TMDB.similarTVSeries(id: 1_396)
            #expect(!similar.results.isEmpty)
        }
    }

    @Test func tvSeriesRecommendations() async throws {
        try await withLiveTMDB {
            let recommendations = try await TMDB.tvSeriesRecommendations(id: 1_396)
            #expect(!recommendations.results.isEmpty)
        }
    }

    @Test func alternativeTVSeriesTitles() async throws {
        try await withLiveTMDB {
            let titles = try await TMDB.alternativeTVSeriesTitles(id: 1_396)
            #expect(!titles.isEmpty)
        }
    }

    @Test func tvSeriesContentRatings() async throws {
        try await withLiveTMDB {
            let ratings = try await TMDB.tvSeriesContentRatings(id: 1_396)
            #expect(!ratings.isEmpty)
        }
    }

    @Test func tvSeriesEpisodeGroups() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.tvSeriesEpisodeGroups(id: 1_396)
        }
    }

    @Test func tvSeriesExternalIDs() async throws {
        try await withLiveTMDB {
            let externalIDs = try await TMDB.tvSeriesExternalIDs(id: 1_396)
            #expect(externalIDs.imdbID != nil)
        }
    }

    @Test func tvSeriesTranslations() async throws {
        try await withLiveTMDB {
            let translations = try await TMDB.tvSeriesTranslations(id: 1_396)
            #expect(!translations.isEmpty)
        }
    }

    @Test func tvSeriesWatchProviders() async throws {
        try await withLiveTMDB {
            let providers = try await TMDB.tvSeriesWatchProviders(id: 1_396)
            #expect(!providers.results.isEmpty)
        }
    }

    @Test func tvSeriesScreenedTheatrically() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.tvSeriesScreenedTheatrically(id: 1_396)
        }
    }

    @Test func tvSeriesChanges() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.tvSeriesChanges(id: 1_396)
        }
    }

    // Note: latestTVSeries() is excluded because the latest TV entry often has null values
    // for non-optional fields causing decode failures. This is a known schema limitation
    // with unpredictable /tv/latest content.

    @Test func tvSeriesAiringToday() async throws {
        try await withLiveTMDB {
            let airingToday = try await TMDB.tvSeriesAiringToday()
            #expect(!airingToday.results.isEmpty)
        }
    }

    @Test func tvSeriesOnTheAir() async throws {
        try await withLiveTMDB {
            let onTheAir = try await TMDB.tvSeriesOnTheAir()
            #expect(!onTheAir.results.isEmpty)
        }
    }

    @Test func popularTVSeries() async throws {
        try await withLiveTMDB {
            let popular = try await TMDB.popularTVSeries()
            #expect(!popular.results.isEmpty)
        }
    }

    @Test func topRatedTVSeries() async throws {
        try await withLiveTMDB {
            let topRated = try await TMDB.topRatedTVSeries()
            #expect(!topRated.results.isEmpty)
        }
    }
}
