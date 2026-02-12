import Dependencies
import Foundation
import Testing
@testable import TMDB

struct TVSeasonEndpointTests {
    @Test func tvSeasonDetails() async throws {
        let season = try await TMDB.tvSeasonDetails(seriesID: 1_396, seasonNumber: 1)
        #expect(!season.name.isEmpty)
        #expect(!season.episodes.isEmpty)
    }

    @Test func tvSeasonCredits() async throws {
        let credits = try await TMDB.tvSeasonCredits(seriesID: 1_396, seasonNumber: 1)
        #expect(!credits.cast.isEmpty)
    }

    @Test func tvSeasonAggregateCredits() async throws {
        let credits = try await TMDB.tvSeasonAggregateCredits(seriesID: 1_396, seasonNumber: 1)
        #expect(!credits.cast.isEmpty)
    }

    @Test func tvSeasonExternalIDs() async throws {
        _ = try await TMDB.tvSeasonExternalIDs(seriesID: 1_396, seasonNumber: 1)
    }

    @Test func tvSeasonImages() async throws {
        let images = try await TMDB.tvSeasonImages(seriesID: 1_396, seasonNumber: 1)
        #expect(!images.posters.isEmpty)
    }

    @Test func tvSeasonTranslations() async throws {
        let translations = try await TMDB.tvSeasonTranslations(seriesID: 1_396, seasonNumber: 1)
        #expect(!translations.isEmpty)
    }

    @Test func tvSeasonVideos() async throws {
        _ = try await TMDB.tvSeasonVideos(seriesID: 1_396, seasonNumber: 1)
    }

    @Test func tvSeasonWatchProviders() async throws {
        let providers = try await TMDB.tvSeasonWatchProviders(seriesID: 1_396, seasonNumber: 1)
        #expect(!providers.results.isEmpty)
    }

    @Test func tvSeasonChanges() async throws {
        _ = try await TMDB.tvSeasonChanges(seasonID: 3_624)
    }
}
