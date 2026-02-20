import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct TVSeasonIntegrationTests {
    @Test func tvSeasonDetails() async throws {
        try await withLiveTMDB {
            let season = try await TMDB.tvSeasonDetails(seriesID: 1_396, seasonNumber: 1)
            #expect(!season.name.isEmpty)
            #expect(!season.episodes.isEmpty)
        }
    }

    @Test func tvSeasonCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.tvSeasonCredits(seriesID: 1_396, seasonNumber: 1)
            #expect(!credits.cast.isEmpty)
        }
    }

    @Test func tvSeasonAggregateCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.tvSeasonAggregateCredits(seriesID: 1_396, seasonNumber: 1)
            #expect(!credits.cast.isEmpty)
        }
    }

    @Test func tvSeasonExternalIDs() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.tvSeasonExternalIDs(seriesID: 1_396, seasonNumber: 1)
        }
    }

    @Test func tvSeasonImages() async throws {
        try await withLiveTMDB {
            let images = try await TMDB.tvSeasonImages(seriesID: 1_396, seasonNumber: 1)
            #expect(!images.posters.isEmpty)
        }
    }

    @Test func tvSeasonTranslations() async throws {
        try await withLiveTMDB {
            let translations = try await TMDB.tvSeasonTranslations(seriesID: 1_396, seasonNumber: 1)
            #expect(!translations.isEmpty)
        }
    }

    @Test func tvSeasonVideos() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.tvSeasonVideos(seriesID: 1_396, seasonNumber: 1)
        }
    }

    @Test func tvSeasonWatchProviders() async throws {
        try await withLiveTMDB {
            let providers = try await TMDB.tvSeasonWatchProviders(seriesID: 1_396, seasonNumber: 1)
            #expect(!providers.results.isEmpty)
        }
    }

    @Test func tvSeasonChanges() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.tvSeasonChanges(seasonID: 3_624)
        }
    }
}
