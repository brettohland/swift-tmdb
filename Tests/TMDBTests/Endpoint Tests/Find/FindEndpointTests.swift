import Dependencies
import Foundation
import Testing
@testable import TMDB
import TMDBMocking

struct FindEndpointTests {
    init() { TMDBMockData.register() }
    @Test func findByExternalID() async throws {
        let result = try await TMDB.find(externalID: "tt0137523", source: .imdbID)
        #expect(!result.movieResults.isEmpty)
    }
}
