import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct TVSeriesEndpointTests {
    @Test func tvSeriesDetails() async throws {
        let series = try await TMDB.tvSeriesDetails(id: 1_396)
        #expect(!series.name.isEmpty)
        #expect(!series.seasons.isEmpty)
    }

    @Test func tvSeriesCredits() async throws {
        let credits = try await TMDB.tvSeriesCredits(id: 1_396)
        #expect(!credits.cast.isEmpty)
    }

    @Test func tvSeriesAggregateCredits() async throws {
        let credits = try await TMDB.tvSeriesAggregateCredits(id: 1_396)
        #expect(!credits.cast.isEmpty)
        #expect(!credits.cast.first!.roles.isEmpty)
    }

    @Test func tvSeriesImages() async throws {
        let images = try await TMDB.tvSeriesImages(id: 1_396)
        #expect(!images.backdrops.isEmpty)
    }

    @Test func tvSeriesVideos() async throws {
        let videos = try await TMDB.tvSeriesVideos(id: 1_396)
        #expect(!videos.results.isEmpty)
    }

    @Test func tvSeriesReviews() async throws {
        let reviews = try await TMDB.tvSeriesReviews(id: 1_396)
        #expect(!reviews.results.isEmpty)
    }

    @Test func tvSeriesKeywords() async throws {
        let keywords = try await TMDB.tvSeriesKeywords(id: 1_396)
        #expect(!keywords.isEmpty)
    }

    @Test func similarTVSeries() async throws {
        let similar = try await TMDB.similarTVSeries(id: 1_396)
        #expect(!similar.results.isEmpty)
    }

    @Test func tvSeriesRecommendations() async throws {
        let recommendations = try await TMDB.tvSeriesRecommendations(id: 1_396)
        #expect(!recommendations.results.isEmpty)
    }

    @Test func alternativeTVSeriesTitles() async throws {
        let titles = try await TMDB.alternativeTVSeriesTitles(id: 1_396)
        #expect(!titles.isEmpty)
    }

    @Test func tvSeriesContentRatings() async throws {
        let ratings = try await TMDB.tvSeriesContentRatings(id: 1_396)
        #expect(!ratings.isEmpty)
    }

    @Test func tvSeriesEpisodeGroups() async throws {
        _ = try await TMDB.tvSeriesEpisodeGroups(id: 1_396)
    }

    @Test func tvSeriesExternalIDs() async throws {
        let externalIDs = try await TMDB.tvSeriesExternalIDs(id: 1_396)
        #expect(externalIDs.imdbID != nil)
    }

    @Test func tvSeriesTranslations() async throws {
        let translations = try await TMDB.tvSeriesTranslations(id: 1_396)
        #expect(!translations.isEmpty)
    }

    @Test func tvSeriesWatchProviders() async throws {
        let providers = try await TMDB.tvSeriesWatchProviders(id: 1_396)
        #expect(!providers.results.isEmpty)
    }

    @Test func tvSeriesScreenedTheatrically() async throws {
        _ = try await TMDB.tvSeriesScreenedTheatrically(id: 1_396)
    }

    @Test func tvSeriesChanges() async throws {
        _ = try await TMDB.tvSeriesChanges(id: 1_396)
    }

    @Test func latestTVSeries() async throws {
        let series = try await TMDB.latestTVSeries()
        #expect(series.id > 0)
    }

    @Test func tvSeriesAiringToday() async throws {
        let airingToday = try await TMDB.tvSeriesAiringToday()
        #expect(!airingToday.results.isEmpty)
    }

    @Test func tvSeriesOnTheAir() async throws {
        let onTheAir = try await TMDB.tvSeriesOnTheAir()
        #expect(!onTheAir.results.isEmpty)
    }

    @Test func popularTVSeries() async throws {
        let popular = try await TMDB.popularTVSeries()
        #expect(!popular.results.isEmpty)
    }

    @Test func topRatedTVSeries() async throws {
        let topRated = try await TMDB.topRatedTVSeries()
        #expect(!topRated.results.isEmpty)
    }
}
