import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct DiscoverIntegrationTests {
    @Test func discoverMovies() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.discoverMovie()
            #expect(!results.results.isEmpty)
        }
    }

    @Test func discoverMoviesWithFilters() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.discoverMovie(filters: .voteCountGreaterThan(100))
            #expect(!results.results.isEmpty)
        }
    }

    @Test func discoverTV() async throws {
        try await withLiveTMDB {
            let results = try await TMDB.discoverTV()
            #expect(!results.results.isEmpty)
        }
    }
}
