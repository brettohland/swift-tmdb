import Dependencies
import Foundation
import Mocks
import SharedModels
import Testing
@testable import TMDB

struct DiscoverEndpointTests {
    @Test func discoverMovies() async throws {
        _ = try await TMDB.Client.Discover.movies()
    }

    @Test func discoverTV() async throws {
        _ = try await TMDB.Client.Discover.tv()
    }
}
