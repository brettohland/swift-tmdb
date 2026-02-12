import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct GenreEndpointTests {
    init() { TMDBMockData.register() }
    @Test func movieGenres() async throws {
        let genres = try await TMDB.movieGenres()
        #expect(!genres.genres.isEmpty)
    }

    @Test func tvGenres() async throws {
        let genres = try await TMDB.tvGenres()
        #expect(!genres.genres.isEmpty)
    }
}
