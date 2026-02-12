import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct TVEpisodeEndpointTests {
    init() { TMDBMockData.register() }
    @Test func tvEpisodeDetails() async throws {
        let episode = try await TMDB.tvEpisodeDetails(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
        #expect(!episode.name.isEmpty)
    }

    @Test func tvEpisodeCredits() async throws {
        let credits = try await TMDB.tvEpisodeCredits(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
        #expect(!credits.cast.isEmpty)
    }

    @Test func tvEpisodeExternalIDs() async throws {
        let externalIDs = try await TMDB.tvEpisodeExternalIDs(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
        #expect(externalIDs.imdbID != nil)
    }

    @Test func tvEpisodeImages() async throws {
        let images = try await TMDB.tvEpisodeImages(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
        #expect(!images.stills.isEmpty)
    }

    @Test func tvEpisodeTranslations() async throws {
        let translations = try await TMDB.tvEpisodeTranslations(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
        #expect(!translations.isEmpty)
    }

    @Test func tvEpisodeVideos() async throws {
        _ = try await TMDB.tvEpisodeVideos(seriesID: 1_396, seasonNumber: 1, episodeNumber: 1)
    }

    @Test func tvEpisodeChanges() async throws {
        _ = try await TMDB.tvEpisodeChanges(episodeID: 62_085)
    }
}
