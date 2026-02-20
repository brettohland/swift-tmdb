import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct WatchProviderIntegrationTests {
    @Test func regions() async throws {
        try await withLiveTMDB {
            let regions = try await TMDB.watchProviderRegions()
            #expect(!regions.results.isEmpty)
        }
    }

    @Test func movieProviders() async throws {
        try await withLiveTMDB {
            let providers = try await TMDB.movieWatchProviders()
            #expect(!providers.results.isEmpty)
        }
    }

    @Test func tvProviders() async throws {
        try await withLiveTMDB {
            let providers = try await TMDB.tvWatchProviders()
            #expect(!providers.results.isEmpty)
        }
    }
}
