import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct GenreIntegrationTests {
    @Test func movieGenres() async throws {
        try await withLiveTMDB {
            let genres = try await TMDB.movieGenres()
            #expect(!genres.genres.isEmpty)
        }
    }

    @Test func tvGenres() async throws {
        try await withLiveTMDB {
            let genres = try await TMDB.tvGenres()
            #expect(!genres.genres.isEmpty)
        }
    }
}
