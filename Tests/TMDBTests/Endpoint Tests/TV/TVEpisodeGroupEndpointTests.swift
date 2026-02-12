import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct TVEpisodeGroupEndpointTests {
    init() { TMDBMockData.register() }
    @Test func episodeGroupDetails() async throws {
        let group = try await TMDB.episodeGroupDetails(id: "657098ca79a1c300fe780f0a")
        #expect(!group.name.isEmpty)
        #expect(!group.groups.isEmpty)
    }
}
