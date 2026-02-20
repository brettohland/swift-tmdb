import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct TVEpisodeGroupIntegrationTests {
    @Test func episodeGroupDetails() async throws {
        try await withLiveTMDB {
            let group = try await TMDB.episodeGroupDetails(id: "657098ca79a1c300fe780f0a")
            #expect(!group.name.isEmpty)
            #expect(!group.groups.isEmpty)
        }
    }
}
