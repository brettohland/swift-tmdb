import Dependencies
import Foundation
import Testing
@testable import TMDB

@Suite(.serialized, .enabled(if: TMDBCredential.isAvailable))
struct FindIntegrationTests {
    @Test func findByIMDbID() async throws {
        try await withLiveTMDB {
            let result = try await TMDB.find(externalID: "tt0137523", source: .imdbID)
            #expect(!result.movieResults.isEmpty)
            #expect(result.movieResults.first?.id == 550)
        }
    }
}
