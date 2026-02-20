import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct WatchProviderEndpointTests {
    @Test func regions() async throws {
        let regions = try await TMDB.watchProviderRegions()
        #expect(!regions.results.isEmpty)
    }

    @Test func movieProviders() async throws {
        let providers = try await TMDB.movieWatchProviders()
        #expect(!providers.results.isEmpty)
    }

    @Test func tvProviders() async throws {
        let providers = try await TMDB.tvWatchProviders()
        #expect(!providers.results.isEmpty)
    }
}
