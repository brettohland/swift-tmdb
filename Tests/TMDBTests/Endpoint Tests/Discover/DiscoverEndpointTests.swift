import Dependencies
import Foundation

import Testing
@testable import TMDB

struct DiscoverEndpointTests {
    @Test func discoverMovies() async throws {
        _ = try await TMDB.discoverMovies()

        _ = try await TMDB.discoverMovies(filters: .voteCountGreaterThan(1), .certification("test"))
    }

    @Test func discoverTV() async throws {
        _ = try await TMDB.discoverTV()
    }

}
