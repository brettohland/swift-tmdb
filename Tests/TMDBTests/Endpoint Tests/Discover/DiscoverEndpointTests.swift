import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct DiscoverEndpointTests {
    init() { TMDBMockData.register() }
    @Test func discoverMovies() async throws {
        let results = try await TMDB.discoverMovie()
        #expect(!results.results.isEmpty)

        _ = try await TMDB.discoverMovie(filters: .voteCountGreaterThan(1), .certification("test"))
    }

    @Test func discoverTV() async throws {
        let results = try await TMDB.discoverTV()
        #expect(!results.results.isEmpty)
    }

}
