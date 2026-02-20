import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct TVEpisodeIntegrationTests {
    @Test func tvEpisodeDetails() async throws {
        try await withLiveTMDB {
            let episode = try await TMDB.tvEpisodeDetails(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
            #expect(!episode.name.isEmpty)
        }
    }

    @Test func tvEpisodeCredits() async throws {
        try await withLiveTMDB {
            let credits = try await TMDB.tvEpisodeCredits(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
            #expect(!credits.cast.isEmpty)
        }
    }

    @Test func tvEpisodeExternalIDs() async throws {
        try await withLiveTMDB {
            let externalIDs = try await TMDB.tvEpisodeExternalIDs(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
            #expect(externalIDs.imdbID != nil)
        }
    }

    @Test func tvEpisodeImages() async throws {
        try await withLiveTMDB {
            let images = try await TMDB.tvEpisodeImages(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
            #expect(!images.stills.isEmpty)
        }
    }

    @Test func tvEpisodeTranslations() async throws {
        try await withLiveTMDB {
            let translations = try await TMDB.tvEpisodeTranslations(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
            #expect(!translations.isEmpty)
        }
    }

    @Test func tvEpisodeVideos() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.tvEpisodeVideos(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
        }
    }

    @Test func tvEpisodeChanges() async throws {
        try await withLiveTMDB {
            _ = try await TMDB.tvEpisodeChanges(episodeID: 62_085)
        }
    }
}
