import Dependencies
import Foundation
import Testing
@testable import TMDB

struct DiscoverEndpointTests {
    @Test func discoverMovies() async throws {
        _ = try await TMDB.discoverMovie()

        _ = try await TMDB.discoverMovie(filters: .voteCountGreaterThan(1), .certification("test"))
    }

    @Test func discoverTV() async throws {
        _ = try await TMDB.discoverTV()
    }

}
